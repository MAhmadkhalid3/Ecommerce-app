import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/popups/shmiled_loader.dart';
import '../../../personalization/models/brand_modal.dart';
import '../all_product/all_product_screen.dart';

class TBrandShimmer extends StatelessWidget {
  const TBrandShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg(context)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Logo shimmer
              TShimmerEffect(width: 40, height: 40, radius: 8),

              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    // Name shimmer
                    TShimmerEffect(width: 60, height: 12),
                    const SizedBox(height: 6),
                    // Product count shimmer
                    TShimmerEffect(width: 50, height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// BrandCard Widget
class BrandCard extends StatelessWidget {
  final BrandModal brand;

  const BrandCard({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => Get.to(() => AllProducts(
      title: brand.name, // Brand ka naam title mein
      query:  FirebaseFirestore.instance
        .collection('Products')
        .where('brandId', isEqualTo: brand.brandId), // ✅ Brand filter
    )),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(
            TSizes.cardRadiusLg(context),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Brand Logo (shirt ki jagah)
            CachedNetworkImage(
              imageUrl: brand.image,color: THelperFunction.isDrak(context)? Colors.white:Colors.black,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Icon(FontAwesomeIcons.shirt),
              errorWidget: (context, url, error) => const Icon(FontAwesomeIcons.shirt),
            ),

            SizedBox(
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          brand.name, // ✅ Backend se
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (brand.isFeatured) // ✅ Featured ho to verified badge
                        const Icon(Icons.verified, size: 16, color: Colors.blue),
                    ],
                  ),
                  Text(
                    "${brand.productCount} Products Listed", // ✅ Backend se
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class FeaturedBrandHeading extends StatelessWidget {
  final String text;
  final VoidCallback ontab;
  final double fontsize;
  const FeaturedBrandHeading({
    super.key, required this.ontab, required this.text, required this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: fontsize)),
      TextButton(onPressed: ontab,child:const Text("View all",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
      )],);
  }
}