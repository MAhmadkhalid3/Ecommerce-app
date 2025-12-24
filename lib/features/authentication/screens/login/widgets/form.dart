import 'package:ecommerce/features/authentication/screens/forgetpassword/forgetpassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class TForm extends StatelessWidget {
  const TForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections(context)),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right), labelText: "E-Mail"),
          ),
          SizedBox(
            height: TSizes.spaceBtwItems(context),
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              hintText: "Password",
            ),
          ),
          SizedBox(
            height: TSizes.spaceBtwItems(context) / 2,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  visualDensity: const VisualDensity(
                    horizontal: -2.0,
                  ), // tighten spacing
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text(
                  "Remember me",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
            InkWell(
              onTap: () {
                Get.to(const ForgetpasswordScreen());
              },
              child: const Text(
                "Forget password?",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            )
          ])
        ],
      ),
    ));
  }
}
