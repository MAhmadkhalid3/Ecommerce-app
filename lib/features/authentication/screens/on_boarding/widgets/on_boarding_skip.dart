import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/on_boarding_controller.dart';

class onBoardingSkip extends StatelessWidget {
  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnBoardingController>();

    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: TSizes.defaultSpace(context),
        child: TextButton(
            onPressed: () {
              controller.skip();
            },
            child: Text(
              "Skip",
              style: Theme.of(context).textTheme.bodyMedium,
            )));
  }
}
