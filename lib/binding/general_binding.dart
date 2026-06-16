import 'package:ecommerce/features/authentication/controllers/google_sign_in_controller.dart';
import 'package:ecommerce/features/authentication/controllers/login_controller.dart';
import 'package:ecommerce/features/shop/controller/address_controller.dart';
import 'package:ecommerce/features/shop/controller/app_settings_controller.dart';
import 'package:ecommerce/features/shop/controller/bank_account_controller.dart';
import 'package:ecommerce/features/shop/controller/cart_controller.dart';
import 'package:ecommerce/features/shop/controller/notification_settings_controller.dart';
import 'package:ecommerce/features/shop/controller/order_controller.dart';
import 'package:ecommerce/features/shop/controller/product_controller.dart';
import 'package:ecommerce/features/shop/controller/wishlist_controller.dart';
import 'package:ecommerce/utils/network/network_manager.dart';
import 'package:get/get.dart';

import '../data/repositories/user_repository.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());
    Get.put(UserRepository());
    Get.put(LoginController());
    Get.put(GoogleSignInController());
    Get.put(ProductController());
    Get.put(CartController());
    Get.put(AddressController());
    Get.put(OrderController());
    Get.put(NotificationSettingsController());
    Get.put(AppSettingsController());
    Get.put(BankAccountController());
    Get.put(WishlistController());
  }
}
