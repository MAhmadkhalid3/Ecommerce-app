import 'package:ecommerce/features/authentication/controllers/google_sign_in_controller.dart';
import 'package:ecommerce/features/authentication/controllers/login_controller.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/button.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/divider.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/footer.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/form.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/haeder.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDrak(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: TSizes.defaultSpace(context),
              right: TSizes.defaultSpace(context),
              top: TSizes.appBarHeight,
              bottom: TSizes.defaultSpace(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Logo, Title, SubTitle
              TLogin_Header(isDark: isDark),

              /// Form
              const TForm(),

              const TButtons(),

              SizedBox(
                height: TSizes.spaceBtwItems(context),
              ),
              const TDivider(),
              SizedBox(
                height: TSizes.spaceBtwItems(context) * 1.5,
              ),

              const Footer()
            ],
          ),
        ),
      ),
    );
  }
}
