import 'package:ecommerce/features/shop/controller/change_name_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/home_Widgets/custom_appbar.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller = Get.put(ChangeNameController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Change Name",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace(context)),
        child: Column(
          children: [
            SizedBox(
              height: TSizes.spaceBtwItems(context) * 1.2,
            ),
            Text(
              "Use real name for easy verification. This name will appear on various pages. ",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections(context) * 1.2,
            ),
            Form(key: Controller.saveFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: Controller.firstNameController,
                    validator: (value)=> TValidator.validateEmptyText(value),
                    maxLines: 1,
                    decoration: InputDecoration(labelText: "First Name"),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwInputFields(context),
                  ),
                  TextFormField(
                    controller: Controller.lastNameController,
                    validator: (value)=> TValidator.validateEmptyText(value),
                    maxLines: 1,
                    decoration: InputDecoration(labelText: "Last Name"),
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
                onPressed: Controller.updateUserName,
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
