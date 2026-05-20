import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/sizes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              /// Image
              Lottie.asset(
                image,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
               SizedBox(height: TSizes.spaceBtwSections(context)),

              /// Title & SubTitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSizes.spaceBtwItems(context)),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
               SizedBox(height: TSizes.spaceBtwSections(context)),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Center(child: const Text("Continue")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}class TSpacingStyle {
  static const EdgeInsets paddingWithAppBarHeight =
  EdgeInsets.only(top: kToolbarHeight, left: 16, right: 16, bottom: 16);
}
