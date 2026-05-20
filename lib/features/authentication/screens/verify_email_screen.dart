import 'package:ecommerce/features/authentication/controllers/email_verify_controller.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'login/login_screen.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String? email;

  const VerifyEmailScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        /// Padding to Give Default Equal Space on all sides in all screens.
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

              /// Image
              SizedBox(height: TSizes.spaceBtwSections(context)),

              /// Title & SubTitle
              Text(
                "Verify your email address",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSizes.spaceBtwItems(context)),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSizes.spaceBtwItems(context)),
              Text(
                "Congratulations! Your Account Awaits: Verify Your Email to Start Shopping and Experience a World of Unrivaled Deals and Personalized Offers ",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSizes.spaceBtwSections(context)),

              /// Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.checkEmailVerificationStatus();
                    },
                    child: const Text("Continue"),
                  )),
              SizedBox(
                height: TSizes.spaceBtwItems(context),
              ),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () { controller.sendEmailVerification();},
                      child: Text("resent email")))
            ],
          ),
        ),
      ),
    );
  }
}
