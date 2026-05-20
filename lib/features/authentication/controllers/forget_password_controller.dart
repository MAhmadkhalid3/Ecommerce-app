import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../utils/constants/images_string.dart';
import '../../../utils/network/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../screens/resetScreen/resetscreen.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

/// Variables
  GlobalKey<FormState> forgetPaawordFormKey = GlobalKey<FormState>();
  final email = TextEditingController();

  /// SendPasswordResetEmail for Reset Password Link
  Future<void> sendPasswordResetEmail() async {
    try {
      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "Warning", message: 'No Internet Connection');
        return;
      }
      // Form Validation
      if (!forgetPaawordFormKey.currentState!.validate()) return;

      TFullScreenLoader.openLoadingDialog(
        "We are processing your information....",
        TImages.lottieDocer,
      );

     await AuthenticationRepository.instance.forgetPassword(email.text.trim());
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Email Sent!',
        message: 'Email Link Sent to Reset Your Password!',
      );
      Get.off(()=> ResetScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading(); // pehle loader close karo
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// ReSentPasswordResetEmail to ReSend Link
  Future<void> resendPasswordResetEmail() async {
    try {
      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "Warning", message: 'No Internet Connection');
        return;
      }

      TFullScreenLoader.openLoadingDialog(
        "We are processing your information....",
        TImages.lottieDocer,
      );

      await AuthenticationRepository.instance.forgetPassword(email.text.trim());
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Email Sent!',
        message: 'Email Link Sent to Reset Your Password!',
      );

    } catch (e) {
      TFullScreenLoader.stopLoading(); // pehle loader close karo
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
