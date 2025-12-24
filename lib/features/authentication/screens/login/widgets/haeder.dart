import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class TLogin_Header extends StatelessWidget {
  const TLogin_Header({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      /// Logo, Title, SubTitle
      Align(
        alignment: Alignment.topLeft,
        child: Image(
          height: TDeviceUtils.getScreenHeight(context) * 0.183,
          image: isDark
              ? const AssetImage("assets/logos/t-store-splash-logo-white.png")
              : const AssetImage("assets/logos/t-store-splash-logo-black.png"),
        ),
      ),

      Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Welcome back",
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      const SizedBox(
        height: 2,
      ),
      Text(
        "Discover Limitless Choices and Unmatched Convenience",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      SizedBox(
        height: TSizes.spaceBtwItems(context),
      ),
    ]);
  }
}
