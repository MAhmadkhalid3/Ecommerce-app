import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/on_boarding_controller.dart';

class smoothIndicator extends StatelessWidget {
  smoothIndicator({
    super.key,
  });
  final controller = Get.find<OnBoardingController>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnBoardingController>();
    final bool dark = THelperFunction.isDrak(context);
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        left: TSizes.defaultSpace(context),
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(
              dotHeight: 3,
              activeDotColor: dark ? TColors.white : TColors.dark),
        ));
  }
}
