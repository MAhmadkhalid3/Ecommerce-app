import 'package:get/get.dart';

import '../../../utils/constants/enum.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/popups/loaders.dart';
import 'cart_controller.dart';
import '../models/address_model.dart';
import '../models/order_model.dart';

const String _kOrdersStorageKey = 'user_orders';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final _localStorage = TLocalStorage();
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadOrdersFromStorage();
  }

  void _loadOrdersFromStorage() {
    try {
      final raw = _localStorage.readData<List<dynamic>>(_kOrdersStorageKey);
      if (raw == null || raw.isEmpty) return;

      final loaded = raw
          .map((e) => OrderModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .where((o) => o.id.isNotEmpty)
          .toList();

      orders.assignAll(loaded.reversed.toList());
    } catch (_) {
      orders.clear();
      _localStorage.removeData(_kOrdersStorageKey);
    }
  }

  Future<void> _saveOrdersToStorage() async {
    final data = orders.map((o) => o.toJson()).toList().reversed.toList();
    await _localStorage.saveData(_kOrdersStorageKey, data);
  }

  Future<bool> placeOrder({
    required AddressModel address,
    required PaymentMethods paymentMethod,
    required double orderTotal,
    String? promoCode,
  }) async {
    final cart = CartController.instance;
    if (cart.cartItems.isEmpty) {
      TLoaders.warningSnackBar(
        title: 'Cart is empty',
        message: 'Add products before placing an order.',
      );
      return false;
    }

    final order = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now().toIso8601String(),
      totalAmount: orderTotal,
      status: OrderStatus.processing.name,
      deliveryAddress: '${address.fullName}\n${address.phoneNumber}\n${address.fullAddress}',
      paymentMethod: paymentMethod.name,
      items: cart.cartItems.map((i) => i.toStorageJson()).toList(),
    );

    orders.insert(0, order);
    orders.refresh();
    await _saveOrdersToStorage();

    cart.clearCart();

    TLoaders.successSnackBar(
      title: 'Order placed',
      message: 'Your order has been placed successfully.',
    );
    return true;
  }
}
