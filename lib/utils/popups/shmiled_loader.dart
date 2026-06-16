import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../helpers/helper_functions.dart';

class TShimmerEffect extends StatelessWidget {
  const TShimmerEffect({
    Key? key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  }) : super(key: key);

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDrak(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? TColors.darkerGrey : TColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
class TVerticalProductShimmer extends StatelessWidget {
  const TVerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 260,
      ),
      itemBuilder: (_, __) =>  SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Image
            TShimmerEffect(width: 180, height: 180),
            SizedBox(height: TSizes.spaceBtwItems(context)),

            /// Text
            TShimmerEffect(width: 160, height: 15),
            SizedBox(height: TSizes.spaceBtwItems(context) / 2),
            TShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}