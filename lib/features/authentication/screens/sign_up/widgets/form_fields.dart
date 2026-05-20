import 'package:ecommerce/features/authentication/controllers/signup_controller.dart';
import 'package:ecommerce/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; 
import '../../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class forms_fields extends StatelessWidget {
  const forms_fields({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(key: controller.signupFormkey,
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextFormField(controller: controller.firstName,
              validator:(value)=> TValidator.validateEmptyText(value),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.user),
                  labelText: "First Name",
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black)),
            )),
            SizedBox(
              width: TSizes.spaceBtwInputFields(context) / 1.6,
            ),
            Expanded(
                child: TextFormField(controller: controller.lastName,
                  validator:(value)=> TValidator.validateEmptyText(value),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.user),
                  labelText: "Last Name",
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black)),
            ))
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        ),
        TextFormField(controller: controller.userName,
          validator:(value)=> TValidator.validateEmptyText(value),
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Iconsax.user_edit,
              ),
              labelText: "UserName"),
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        ),
        TextFormField(controller: controller.email,
          validator:(value)=> TValidator.validateEmail(value),
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Iconsax.direct,
              ),
              labelText: "E-Mail"),
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        ),
        TextFormField(controller: controller.phoneNumber,
          validator:(value)=> TValidator.validatePhoneNumber(value),
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Iconsax.call,
              ),
              labelText: "Phone Number"),
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        ),
        Obx(
    ()=> TextFormField(controller: controller.password,obscureText: controller.ishide.value,
            validator:(value)=> TValidator.validatePassword(value),
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Iconsax.password_check,
                ),
                labelText: "Password",
              suffixIcon: InkWell(onTap: () => controller.ishide.value = !controller.ishide.value ,
                child: Icon(
                controller.ishide.value
                ? Icons.visibility_off
                          : Icons.visibility,
                ),
              ),

              ),),
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        )
      ],
    ));
  }
}
