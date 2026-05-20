import 'package:ecommerce/features/authentication/controllers/google_sign_in_controller.dart';
import 'package:ecommerce/features/authentication/controllers/login_controller.dart';
import 'package:ecommerce/features/shop/controller/product_controller.dart';
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
  }
}
