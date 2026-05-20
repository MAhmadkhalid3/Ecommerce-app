import 'package:ecommerce/features/authentication/screens/sign_up/widgets/Tdevider.dart';
import 'package:ecommerce/features/authentication/screens/sign_up/widgets/button.dart';
import 'package:ecommerce/features/authentication/screens/sign_up/widgets/chexkbox_text.dart';
import 'package:ecommerce/features/authentication/screens/sign_up/widgets/footer_social_icon.dart';
import 'package:ecommerce/features/authentication/screens/sign_up/widgets/form_fields.dart';
import 'package:ecommerce/features/authentication/screens/sign_up/widgets/header.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDrak(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : TColors.primary, //
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace(context)),
          child: Column(
            children: [
              const Header_text(),
              SizedBox(height: TSizes.spaceBtwSections(context)),
              forms_fields(isDark: isDark),
              checkbox_or_text(isDark: isDark),
              SizedBox(
                height: TSizes.spaceBtwItems(context),
              ),
              const button(),
              SizedBox(
                height: TSizes.spaceBtwItems(context) * 1.5,
              ),
              TDevider(isDark: isDark),
              SizedBox(
                height: TSizes.spaceBtwItems(context),
              ),
              const footer_soicial_icon()
            ],
          ),
        ),
      ),
    );
  }
}
