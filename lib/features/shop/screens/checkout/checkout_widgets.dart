import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/features/shop/controller/address_controller.dart';
import 'package:ecommerce/features/shop/controller/cart_controller.dart';
import 'package:ecommerce/features/shop/models/address_model.dart';
import 'package:ecommerce/features/shop/screens/address/add_address_screen.dart';
import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enum.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CheckoutProductTile extends StatelessWidget {
  const CheckoutProductTile({super.key, required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDrak(context);
    final size = item.selectedSize ??
        item.variation?.attributeValues['Size']?.toString();
    final color = item.variation?.attributeValues['Color']?.toString();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 56,
              width: 56,
              child: item.displayImage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: item.displayImage,
                      fit: BoxFit.cover,
                    )
                  : Container(color: TColors.lightGrey),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TBrandIconWithVerificationTitle(
                  isdark: isDark,
                  text: item.product.brand.name,
                  IconSize: 14,
                  fontSize: 13,
                ),
                const SizedBox(height: 4),
                Text(
                  item.displayTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (size != null && size.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        const TextSpan(text: 'Size '),
                        TextSpan(
                          text: size,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
                if (color != null && color.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        const TextSpan(text: 'Color '),
                        TextSpan(
                          text: color,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.subtotal,
    required this.shippingFee,
    required this.taxFee,
    required this.discount,
    required this.orderTotal,
  });

  final double subtotal;
  final double shippingFee;
  final double taxFee;
  final double discount;
  final double orderTotal;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDrak(context);

    return Container(
      padding: EdgeInsets.all(TSizes.defaultSpace(context)),
      decoration: BoxDecoration(
        color: isDark ? TColors.darkGrey : TColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? TColors.darkGrey : TColors.grey.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          _SummaryRow(label: 'Subtotal', value: subtotal),
          const SizedBox(height: 8),
          _SummaryRow(label: 'Shipping Fee', value: shippingFee),
          const SizedBox(height: 8),
          _SummaryRow(label: 'Tax Fee', value: taxFee),
          if (discount > 0) ...[
            const SizedBox(height: 8),
            _SummaryRow(
              label: 'Discount',
              value: -discount,
              valueColor: Colors.green,
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Total',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '\$${orderTotal.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final double value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final display = value < 0
        ? '-\$${(-value).toStringAsFixed(2)}'
        : '\$${value.toStringAsFixed(2)}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          display,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: valueColor,
              ),
        ),
      ],
    );
  }
}

class CheckoutSectionHeader extends StatelessWidget {
  const CheckoutSectionHeader({
    super.key,
    required this.title,
    required this.onChange,
  });

  final String title;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        TextButton(
          onPressed: onChange,
          child: Text(
            'Change',
            style: TextStyle(
              color: TColors.primary.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

void showSelectAddressSheet({
  required BuildContext context,
  required AddressModel? selectedAddress,
  required ValueChanged<AddressModel> onSelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      final addressController = AddressController.instance;
      AddressModel? tempSelected = selectedAddress;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              left: TSizes.defaultSpace(context),
              right: TSizes.defaultSpace(context),
              top: TSizes.defaultSpace(context),
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  TSizes.defaultSpace(context),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      'Select Address',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Get.to(() => const AddAddressScreen());
                      },
                      child: const Text('View all'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Obx(() {
                  if (addressController.addresses.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'No saved addresses. Add a delivery address to continue.',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return Column(
                    children: addressController.addresses.map((address) {
                      final isSelected = tempSelected?.id == address.id;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            setModalState(() => tempSelected = address);
                            onSelected(address);
                            Navigator.pop(ctx);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? TColors.primary.withValues(alpha: 0.08)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? TColors.primary
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${address.addressType} Address',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(address.fullName),
                                      Text(address.phoneNumber),
                                      const SizedBox(height: 4),
                                      Text(
                                        address.fullAddress,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Radio<AddressModel>(
                                  value: address,
                                  groupValue: tempSelected,
                                  activeColor: TColors.primary,
                                  onChanged: (v) {
                                    if (v == null) return;
                                    setModalState(() => tempSelected = v);
                                    onSelected(v);
                                    Navigator.pop(ctx);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(ctx);
                      await Get.to(() => const AddAddressScreen());
                    },
                    child: const Text('Add new address'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    },
  );
}

void showSelectPaymentSheet({
  required BuildContext context,
  required PaymentMethods selectedMethod,
  required ValueChanged<PaymentMethods> onSelected,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _PaymentOptionTile(
              icon: Iconsax.money,
              title: 'Cash on Delivery',
              subtitle: 'Pay when your order arrives',
              method: PaymentMethods.cashOnDelivery,
              selected: selectedMethod,
              onTap: () {
                onSelected(PaymentMethods.cashOnDelivery);
                Navigator.pop(ctx);
              },
            ),
            const SizedBox(height: 10),
            _PaymentOptionTile(
              icon: Iconsax.wallet,
              title: 'JazzCash',
              subtitle: 'Pay via JazzCash mobile wallet',
              method: PaymentMethods.jazzcash,
              selected: selectedMethod,
              onTap: () {
                onSelected(PaymentMethods.jazzcash);
                Navigator.pop(ctx);
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}

class _PaymentOptionTile extends StatelessWidget {
  const _PaymentOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final PaymentMethods method;
  final PaymentMethods selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == method;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? TColors.primary : Colors.grey.shade300,
          ),
          color: isSelected
              ? TColors.primary.withValues(alpha: 0.06)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(icon, color: TColors.primary, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Radio<PaymentMethods>(
              value: method,
              groupValue: selected,
              activeColor: TColors.primary,
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}

String paymentMethodLabel(PaymentMethods method) {
  switch (method) {
    case PaymentMethods.cashOnDelivery:
      return 'Cash on Delivery';
    case PaymentMethods.jazzcash:
      return 'JazzCash';
  }
}

IconData paymentMethodIcon(PaymentMethods method) {
  switch (method) {
    case PaymentMethods.cashOnDelivery:
      return Iconsax.money;
    case PaymentMethods.jazzcash:
      return Iconsax.wallet;
  }
}
