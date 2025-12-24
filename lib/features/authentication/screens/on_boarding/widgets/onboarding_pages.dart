import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class OnBoardingPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String subTitle;

  const OnBoardingPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(TSizes.defaultSpace(context)),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: THelperFunction.ScreenHeight(context) * 0.6,
            width: THelperFunction.ScreenWidth(context) * 0.8,
          ),

          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}