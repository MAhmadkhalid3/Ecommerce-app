import 'package:ecommerce/features/authentication/screens/resetScreen/resetscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';

class ForgetpasswordScreen extends StatelessWidget {
  const ForgetpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right), labelText: "E-Mail"),
            ),
            SizedBox(
              height: TSizes.spaceBtwSections(context),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.off(const ResetScreen());
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
