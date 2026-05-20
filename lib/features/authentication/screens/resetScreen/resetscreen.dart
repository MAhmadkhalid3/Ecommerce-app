import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/forget_password_controller.dart';
import '../login/login_screen.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace(context)),
          child: Column(
            children: [
              /// Image
              Image(
                image: const AssetImage(
                    "assets/images/animations/sammy-line-man-receives-a-mail.png"),
                width: THelperFunction.ScreenWidth(context) * 0.6,
              ),
              SizedBox(height: TSizes.spaceBtwSections(context)),

              /// Title & SubTitle
              Text(
                "Password Reset Email Sent",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSizes.spaceBtwItems(context)),
              Text(
                "Your account security is your priority We have sent you a Secure Link to Safely Change Your Password and keep Your Account Protected.",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSizes.spaceBtwSections(context)),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => LoginScreen());
                  },
                  child: const Text("Done"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {ForgetPasswordController.instance.resendPasswordResetEmail;},
                  child: const Text("Resend Email"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
