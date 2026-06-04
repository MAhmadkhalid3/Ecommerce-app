import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/controller/address_controller.dart';
import 'package:ecommerce/features/shop/controller/cart_controller.dart';
import 'package:ecommerce/features/shop/controller/order_controller.dart';
import 'package:ecommerce/features/shop/models/address_model.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout_widgets.dart';
import 'package:ecommerce/features/shop/screens/orders/orders_list_screen.dart';
import 'package:ecommerce/features/shop/utils/coupon_helper.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enum.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const double _shippingFee = 5.0;
  static const double _taxRate = 0.10;

  final _promoController = TextEditingController();

  AddressModel? _selectedAddress;
  PaymentMethods _paymentMethod = PaymentMethods.cashOnDelivery;
  String? _appliedPromoCode;
  double _discount = 0;
  bool _freeShipping = false;
  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    _selectedAddress = AddressController.instance.defaultAddress;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cart = CartController.instance;
      if (cart.cartItems.isEmpty) {
        TLoaders.warningSnackBar(
          title: 'Empty cart',
          message: 'Add products to your cart first.',
        );
        Get.back();
        return;
      }
      _promptAddressIfNeeded();
    });
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _promptAddressIfNeeded() {
    final addresses = AddressController.instance.addresses;
    if (_selectedAddress != null || addresses.isEmpty) {
      if (addresses.isEmpty) {
        showSelectAddressSheet(
          context: context,
          selectedAddress: null,
          onSelected: (a) => setState(() => _selectedAddress = a),
        );
      }
      return;
    }
    setState(() => _selectedAddress = AddressController.instance.defaultAddress);
  }

  double _subtotal(CartController cart) => cart.totalCartPrice;

  double _shipping(double subtotal) =>
      _freeShipping || (_appliedPromoCode != null && CouponHelper.grantsFreeShipping(_appliedPromoCode!))
          ? 0
          : _shippingFee;

  double _tax(double subtotal) => (subtotal - _discount) * _taxRate;

  double _orderTotal(CartController cart) {
    final sub = _subtotal(cart);
    return sub - _discount + _shipping(sub) + _tax(sub);
  }

  void _applyPromo() {
    final code = _promoController.text.trim();
    if (code.isEmpty) {
      TLoaders.warningSnackBar(
        title: 'Enter code',
        message: 'Please enter a promo code.',
      );
      return;
    }

    if (!CouponHelper.isValidCode(code)) {
      TLoaders.errorSnackBar(
        title: 'Invalid code',
        message: 'This promo code is not valid.',
      );
      return;
    }

    final cart = CartController.instance;
    final subtotal = _subtotal(cart);

    if (CouponHelper.grantsFreeShipping(code)) {
      setState(() {
        _appliedPromoCode = code.toUpperCase();
        _freeShipping = true;
        _discount = 0;
      });
      TLoaders.successSnackBar(
        title: 'Promo applied',
        message: 'Free shipping on this order!',
      );
      return;
    }

    final discount = CouponHelper.applyDiscount(
      code: code,
      subtotal: subtotal,
      shippingFee: _shippingFee,
    );

    if (discount < 0) {
      TLoaders.warningSnackBar(
        title: 'Minimum not met',
        message: 'Order subtotal is too low for this coupon.',
      );
      return;
    }

    setState(() {
      _appliedPromoCode = code.toUpperCase();
      _discount = discount;
      _freeShipping = false;
    });

    TLoaders.successSnackBar(
      title: 'Promo applied',
      message: 'You saved \$${discount.toStringAsFixed(2)}!',
    );
  }

  Future<void> _placeOrder() async {
    if (_selectedAddress == null) {
      TLoaders.warningSnackBar(
        title: 'Address required',
        message: 'Please select a delivery address.',
      );
      showSelectAddressSheet(
        context: context,
        selectedAddress: null,
        onSelected: (a) => setState(() => _selectedAddress = a),
      );
      return;
    }

    setState(() => _isPlacingOrder = true);

    final cart = CartController.instance;
    final total = _orderTotal(cart);

    final success = await OrderController.instance.placeOrder(
      address: _selectedAddress!,
      paymentMethod: _paymentMethod,
      orderTotal: total,
      promoCode: _appliedPromoCode,
    );

    if (!mounted) return;
    setState(() => _isPlacingOrder = false);

    if (success) {
      Get.off(() => const OrdersListScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;
    final isDark = THelperFunction.isDrak(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Obx(() {
        if (cart.cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }

        final subtotal = _subtotal(cart);
        final shipping = _shipping(subtotal);
        final tax = _tax(subtotal);
        final total = _orderTotal(cart);

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(TSizes.defaultSpace(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...cart.cartItems.map(
                      (item) => CheckoutProductTile(item: item),
                    ),
                    const SizedBox(height: 8),
                    _PromoCodeField(
                      controller: _promoController,
                      onApply: _applyPromo,
                    ),
                    SizedBox(height: TSizes.spaceBtwSections(context)),
                    OrderSummaryCard(
                      subtotal: subtotal,
                      shippingFee: shipping,
                      taxFee: tax,
                      discount: _discount,
                      orderTotal: total,
                    ),
                    SizedBox(height: TSizes.spaceBtwSections(context)),
                    CheckoutSectionHeader(
                      title: 'Payment Method',
                      onChange: () => showSelectPaymentSheet(
                        context: context,
                        selectedMethod: _paymentMethod,
                        onSelected: (m) => setState(() => _paymentMethod = m),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _PaymentDisplay(method: _paymentMethod),
                    SizedBox(height: TSizes.spaceBtwSections(context)),
                    CheckoutSectionHeader(
                      title: 'Shipping Address',
                      onChange: () => showSelectAddressSheet(
                        context: context,
                        selectedAddress: _selectedAddress,
                        onSelected: (a) => setState(() => _selectedAddress = a),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _AddressDisplay(address: _selectedAddress),
                    SizedBox(height: TSizes.spaceBtwSections(context)),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                TSizes.defaultSpace(context),
                12,
                TSizes.defaultSpace(context),
                TSizes.defaultSpace(context),
              ),
              decoration: BoxDecoration(
                color: isDark ? TColors.darkGrey : TColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isPlacingOrder ? null : _placeOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isPlacingOrder
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Checkout \$${total.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _PromoCodeField extends StatelessWidget {
  const _PromoCodeField({
    required this.controller,
    required this.onApply,
  });

  final TextEditingController controller;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDrak(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? TColors.darkGrey : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: onApply,
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentDisplay extends StatelessWidget {
  const _PaymentDisplay({required this.method});

  final PaymentMethods method;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(paymentMethodIcon(method), color: TColors.primary, size: 28),
        const SizedBox(width: 12),
        Text(
          paymentMethodLabel(method),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}

class _AddressDisplay extends StatelessWidget {
  const _AddressDisplay({required this.address});

  final AddressModel? address;

  @override
  Widget build(BuildContext context) {
    if (address == null) {
      return Text(
        'No address selected. Tap Change to add or select one.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.orange.shade800,
            ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address!.fullName,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Iconsax.call, size: 16),
            const SizedBox(width: 6),
            Text(address!.phoneNumber),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Iconsax.location, size: 16),
            const SizedBox(width: 6),
            Expanded(child: Text(address!.fullAddress)),
          ],
        ),
      ],
    );
  }
}
