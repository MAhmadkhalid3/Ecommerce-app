import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon,
    this.backgroundColor,
    required this.showBackground,
    this.showBorder = true,  this.color, this.txtColor,
  });
  final String text;
  final Color? color;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? txtColor;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final bool isdark = THelperFunction.isDrak(context);
    return Container(
      width: double.infinity,
      height: THelperFunction.ScreenHeight(context) * .063,
      decoration: BoxDecoration(
        color: color ??
      (showBackground
      ? (isdark ? TColors.dark : TColors.light)
            : Colors.white),

        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg(context)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: TSizes.spaceBtwItems(context),
          ),
          Icon(
            icon,
            color: showBorder ? Colors.grey.shade700 : null,
          ),
          SizedBox(
            width: TSizes.spaceBtwItems(context),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,  color: showBackground?THelperFunction.isDrak(context)?Colors.white: Colors.black:  txtColor),
          )
        ],
      ),
    );
  }
}
