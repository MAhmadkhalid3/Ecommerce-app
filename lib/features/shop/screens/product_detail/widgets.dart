
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/shmiled_loader.dart';

class PriceWithDiscountTag extends StatelessWidget {
  const PriceWithDiscountTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35,
          decoration: BoxDecoration(
              color: TColors.secondary.withOpacity(.8),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "25%",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "\$210",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .apply(decoration: TextDecoration.lineThrough),
        ),
        const SizedBox(width: 10),
        Text(
          "\$175",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.backgroundColor,
    this.isNetworkImage = false,
    this.borderRadius = 12,
    this.width,
    this.height,
    this.border,
    this.padding,
    this.onPressed,
    this.applyImageRadius = true,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 2,
              right: 2,
              bottom: 5,
            ),
            child: isNetworkImage
                ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit,

              placeholder: (context, url) => TShimmerEffect(
                width: width ?? 50,
                height: height ?? 50,
                radius: borderRadius,
              ),

              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            )
                : Image.asset(
              imageUrl,
              fit: fit,
            ),
          ),
        ),
      ),
    );
  }
}
class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final bool isColor = THelperFunction.getColor(text) != null;
    final color = THelperFunction.getColor(text);

    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? TColors.white : null),

      // ✅ Agar color chip hai to circular avatar dikhao
      avatar: isColor
          ? Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle, // <-- ensures circular shape
        ),
      )
          : null,

      // ✅ Color chips ke liye styling fix
      labelPadding: isColor ? EdgeInsets.zero : null,
      padding: isColor ? EdgeInsets.zero : null,
      shape: isColor
          ? const CircleBorder() // <-- pure circular shape for color chips
          : null,
      backgroundColor: isColor ? color : null,
    );
  }
}
