import 'package:ecommerce/features/authentication/controllers/login_controller.dart';
import 'package:ecommerce/features/shop/controller/change_name_controller.dart';
import 'package:ecommerce/features/shop/controller/reauthenticate_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/home_Widgets/custom_appbar.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
   final Controller = Get.put(ReAuthenticateController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Re-Authenticate User",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace(context)),
        child: Column(
          children: [
            Form(key: Controller.ReAuthFormKey,
              child: Column(
                children: [
                  TextFormField( controller:Controller.email ,

                    validator: (value) => TValidator.validateEmail(value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: "E-Mail"),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems(context),
                  ),

                  Obx(
                        ()=> TextFormField(
                          obscureText:  Controller.hidePassword.value,
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
                ],
              ),
            ),

            SizedBox(
              height: TSizes.spaceBtwSections(context) * 1.2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                 await Controller.Reauth();
                },
                child: const Text("Delete Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
