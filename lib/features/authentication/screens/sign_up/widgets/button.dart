import 'package:ecommerce/features/authentication/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class button extends StatelessWidget {
  const button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  final  controller = Get.put(SignupController());
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.signup(context);
        },
        child: const Text("Sign In"),
      ),
    );
  }
}
