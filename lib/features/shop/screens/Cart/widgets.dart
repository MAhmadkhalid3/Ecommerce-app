import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../home/home.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.isdark,
  });

  final bool isdark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageConatainer(isdark: isdark),
       const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBrandIconWithVerificationTitle(
                isdark: isdark, text: "Nike", IconSize: 10, fontSize: 10),
          const  Text("Red Sport Shoes"),
            Text(
              "Color Green Size EU 23",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            IncreDecreButtonWithPriceTag(isdark: isdark)
          ],
        )
      ],
    );
  }
}

class IncreDecreButtonWithPriceTag extends StatelessWidget {
  const IncreDecreButtonWithPriceTag({
    super.key,
    required this.isdark,
  });

  final bool isdark;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
      radius: 18,
      backgroundColor: isdark ?TColors.darkGrey.withOpacity(.8) : TColors.grey,
      child:const Icon(Iconsax.minus,color: Colors.white,),
    ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text("3",style: Theme.of(context).textTheme.titleMedium,),
      ),
      CircleAvatar(
        radius: 18,
        backgroundColor: isdark ? TColors.darkerGrey : TColors.primary,
        child:const Icon(Iconsax.add,color: Colors.white,),
      ),

      const Text("258"),
    ],);
  }
}

class ImageConatainer extends StatelessWidget {
  const ImageConatainer({
    super.key,
    required this.isdark,
  });

  final bool isdark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isdark ? TColors.darkGrey : TColors.light,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 55,
      width: 55,
      child:
      Image.asset('assets/images/products/NikeAirJOrdonBlackRed.png'),
    );
  }
}