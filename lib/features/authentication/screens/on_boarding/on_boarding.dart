import 'package:ecommerce/features/authentication/controllers.onboarding/on_boardingController.dart';
import 'package:ecommerce/features/authentication/screens/on_boarding/widgets/next_button.dart';
import 'package:ecommerce/features/authentication/screens/on_boarding/widgets/on_boarding_skip.dart';
import 'package:ecommerce/features/authentication/screens/on_boarding/widgets/onboarding_pages.dart';
import 'package:ecommerce/features/authentication/screens/on_boarding/widgets/smooth_Indicator.dart';
import 'package:ecommerce/utils/constants/images_string.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/text_string.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  final controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                  title: TTexts.onBoardingTitle1,
                  imagePath: TImages.onBoardingImage1,
                  subTitle: TTexts.onBoardingSubtitle1),
              OnBoardingPage(
                  title: TTexts.onBoardingTitle2,
                  imagePath: TImages.onBoardingImage2,
                  subTitle: TTexts.onBoardingSubtitle2),
              OnBoardingPage(
                  title: TTexts.onBoardingTitle3,
                  imagePath: TImages.onBoardingImage3,
                  subTitle: TTexts.onBoardingSubtitle3),
            ],
          ),

          /// Skip Button
          const onBoardingSkip(),

          /// Smooth page Indicator
          smoothIndicator(),

          /// Next Button
          const NextButton()
        ],
      ),
    );
  }
}
