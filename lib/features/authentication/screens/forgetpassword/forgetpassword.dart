import 'package:ecommerce/features/authentication/screens/resetScreen/resetscreen.dart';
import 'package:ecommerce/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../controllers/forget_password_controller.dart';

class ForgetpasswordScreen extends StatelessWidget {
  const ForgetpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace(context),
            vertical: TSizes.defaultSpace(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forget Password",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems(context),
            ),
            Text(
              "Don't worry somtes time people can forget too,enter your email and we will send you a password resent link.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: TSizes.spaceBtwSections(context) * 2),
            Form(key: controller.forgetPaawordFormKey,
              child: TextFormField(controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right), labelText: "E-Mail"),
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwSections(context),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.sendPasswordResetEmail();
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
