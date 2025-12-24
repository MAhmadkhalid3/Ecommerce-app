import 'package:ecommerce/features/authentication/screens/sign_up/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../bottomNavigatorBar/bottombar.dart';
import '../../../../../utils/constants/sizes.dart';

class TButtons extends StatelessWidget {
  const TButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavigatorBar(),
                  ));
            },
            child: const Text("Login"),
          ),
        ),
        SizedBox(
          height: TSizes.spaceBtwItems(context),
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Get.to(const SignupScreen());
            },
            child: const Text("Create Account"),
          ),
        ),
      ],
    );
  }
}
