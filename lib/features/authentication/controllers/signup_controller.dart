import 'dart:async';
import 'package:ecommerce/features/personalization/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../utils/constants/images_string.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../../utils/network/network_manager.dart';
import '../screens/verify_email_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final ishide = true.obs;
  final ischeckbox = false.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

  Future<void> signup(BuildContext context) async {
    try {
      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "Warning", message: 'No Internet Connection');
        return;
      }
      // Form Validation
      if (!signupFormkey.currentState!.validate()) return;

      TFullScreenLoader.openLoadingDialog(
        "We are processing your information....",
        TImages.lottieDocer,
      );
     // Accept Privacy Policy
      if (!ischeckbox.value) {
        TFullScreenLoader.stopLoading(); // loader close before snackbar
        TLoaders.warningSnackBar(
          title: "Accept Privacy Policy",
          message: 'You must accept Privacy Policy & Terms of Use.',
        );
        return;
      }
      // Register User
       var userCredentials = await AuthenticationRepository.instance.registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());
      // Email verification bhejna
      await userCredentials.user!.sendEmailVerification();
      final newUser = UserModel(id: userCredentials.user!.uid, firstName: firstName.text, lastName: lastName.text, username: userName.text, email: email.text, phoneNumber: phoneNumber.text, profileImage: "", createdAt: DateTime.now());
      final userRepo = UserRepository.instance;


    await  userRepo.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Success!',
        message: 'Account created successfully!',
      );
      Get.to(VerifyEmailScreen(email: email.text.trim(),));
    } catch (e) {
      TFullScreenLoader.stopLoading(); // pehle loader close karo
      TLoaders.errorSnackBar(title: 'Oh Sniap!', message: e.toString());
    }
  }
}
