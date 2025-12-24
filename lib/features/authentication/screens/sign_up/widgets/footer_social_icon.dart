import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
class footer_soicial_icon extends StatelessWidget {
  const footer_soicial_icon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: 45,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),child: IconButton(onPressed: (){}, icon: Image.asset("assets/logos/google-icon.png")),
        ),
        SizedBox(width: TSizes.spaceBtwItems(context),
        ),
        Container(height: 45,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),child: IconButton(onPressed: (){}, icon: Image.asset("assets/logos/facebook-icon.png")),
        ),
      ],
    );
  }
}