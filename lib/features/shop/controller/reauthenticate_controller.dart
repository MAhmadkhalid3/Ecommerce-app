import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../utils/constants/images_string.dart';
import '../../../utils/network/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/screens/login/login_screen.dart';

class ReAuthenticateController extends GetxController{
  final hidePassword = true.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> ReAuthFormKey = GlobalKey<FormState>();

  Future<void> Reauth() async{
    final controller = AuthenticationRepository.instance;
    try{
      // Form Validation
      if (!ReAuthFormKey.currentState!.validate()) {
        return;
      }
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Processing ...', TImages.lottieDocer);

     await controller.ReAuthUserWithEmailOrPassword(email.text, password.text);
     await controller.deleteAccount();
     TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}