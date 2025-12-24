import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers.onboarding/on_boardingController.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnBoardingController>();
    final bool dark = THelperFunction.isDrak(context);
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        right: TSizes.defaultSpace(context),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: dark ? TColors.primary : TColors.dark),
            onPressed: () {
              controller.nextPage();
            },
            child: const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 30,
            )));
  }
}
