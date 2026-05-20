import 'package:ecommerce/features/authentication/controllers/login_controller.dart';
import 'package:ecommerce/features/authentication/screens/forgetpassword/forgetpassword.dart';
import 'package:ecommerce/utils/validator/validator.dart';
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
    final Controller = Get.find<LoginController>();
    return Form(
        key: Controller.loginFormKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections(context)),
          child: Column(
            children: [
              TextFormField(
                controller: Controller.email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: "E-Mail"),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems(context),
              ),

              Obx(
                ()=> TextFormField( obscureText:  Controller.hidePassword.value,
                  controller: Controller.password,
                  validator: (value) => TValidator.validatePassword(value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),


                    suffixIcon:  InkWell(onTap: () =>  Controller.hidePassword.value  = ! Controller.hidePassword.value ,
                  child: Icon(
                    Controller.hidePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems(context) / 2,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => Checkbox(
                        value: Controller.rememberMe.value,
                        onChanged: (value) {
                          Controller.rememberMe.value =
                              !Controller.rememberMe.value;
                        },
                        visualDensity: const VisualDensity(
                          horizontal: -2.0,
                        ), // tighten spacing
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const Text(
                      "Remember me",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
