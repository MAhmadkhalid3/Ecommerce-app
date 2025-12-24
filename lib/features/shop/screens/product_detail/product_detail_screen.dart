import 'package:ecommerce/common/widgets/customShapes/curves_edges.dart';
import 'package:ecommerce/features/shop/screens/product_detail/widgets.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../common/widgets/home_Widgets/custom_appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../home/home.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isdark = THelperFunction.isDrak(context);
    return SizedBox(
      child: Scaffold(
        bottomNavigationBar: const TBottomAddToCart(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                ClipPath(
                  clipper: TCustomCurvedEdges(),
                  child: Container(
                    height: 320,
                    width: double.infinity,
                    color: isdark ? TColors.darkGrey : TColors.light,
                    child: Image.asset(
                        'assets/images/products/NikeAirJOrdonBlackRed.png'),
                  ),
                ),
                Positioned(
                    bottom: 30,
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsetsGeometry.only(left: 24),
                        itemBuilder: (BuildContext context, int index) {
                          return TRoundedImage(
                              width: 50,
                              height: 100,
                              border: Border.all(color: TColors.primary),
                              backgroundColor:
                                  isdark ? Colors.grey.shade900 : TColors.white,
                              imageUrl:
                                  'assets/images/products/leather_jacket_3.png');
                        },
                        separatorBuilder: (_, __) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: 3,
                      ),
                    )),
                TAppBar(
                  showBackArrow: true,
                  actions: [
                    InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                isdark ? TColors.black : TColors.white,
                            child: const Icon(
                              Iconsax.heart,
                            )))
                  ],
                ),
              ]),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: TSizes.defaultSpace(context)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Iconsax.star5,
                            color: Colors.amber,
                            size: 24,
                          ),
                          const SizedBox(width: 3),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "5.0",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(color: Colors.grey.shade500)),
                            TextSpan(
                                text: " (199)",
                                style: Theme.of(context).textTheme.labelLarge),
                          ])),
                          const Spacer(),
                          const Icon(
                            Icons.share,
                            size: 24,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const PriceWithDiscountTag(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Red Nike sport shoes",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 3.2,
                      ),
                      Row(
                        children: [
                          Text(
                            "Stock",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "In Stock",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(fontSizeDelta: 1.3),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TBrandIconWithVerificationTitle(
                        isdark: isdark,
                        text: 'Nike',
                        IconSize: 10,
                        fontSize: 12,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(TSizes.md(context)),
                        decoration: BoxDecoration(
                            color: isdark ? TColors.darkGrey : TColors.light,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Variation",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Price:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        const SizedBox(width: 5),
                                        Text(
                                          "\$210",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .apply(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontWeightDelta: 1),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "\$175",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .apply(fontWeightDelta: 1),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Stock:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Out of Stock",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .apply(fontWeightDelta: 1),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Colors",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: [
                              TChoiceChip(
                                text: "Green",
                                onSelected: (value) {},
                                selected: true,
                              ),
                              TChoiceChip(
                                text: "Blue",
                                onSelected: (value) {},
                                selected: false,
                              ),
                              TChoiceChip(
                                text: "Red",
                                onSelected: (value) {},
                                selected: false,
                              ),
                              TChoiceChip(
                                text: "Pink",
                                onSelected: (value) {},
                                selected: false,
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sizes",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            spacing: 8,
                            children: [
                              TChoiceChip(
                                text: "EU 24",
                                onSelected: (value) {},
                                selected: true,
                              ),
                              TChoiceChip(
                                text: "EU 26",
                                onSelected: (value) {},
                                selected: false,
                              ),
                              TChoiceChip(
                                text: "EU 28",
                                onSelected: (value) {},
                                selected: false,
                              ),
                              TChoiceChip(
                                text: "EU 32",
                                onSelected: (value) {},
                                selected: false,
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const  Center(
                              child: Text("Checkout"),
                            )),
                      ),
                      const Description(
                        title: 'Discription',
                        discription:
                            "The discripton of this product is cripton of this product is cripton of this product is cripton of this product is cripton of this product is cripton of this product is ",
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reviews(199)",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.title,
    required this.discription,
  });
  final String title;
  final String discription;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        ReadMoreText(
          discription,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: "Show more",
          trimExpandedText: "Show less",
          moreStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
          lessStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isdark = THelperFunction.isDrak(context);
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace(context),
        vertical: TSizes.defaultSpace(context) / 2,
      ),
      decoration: BoxDecoration(
        color: isdark ? TColors.darkGrey : TColors.light,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(TSizes.cardRadiusLg(context)),
          topLeft: Radius.circular(TSizes.cardRadiusLg(context)),
        ),
      ),
      child: Center(
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: isdark ?TColors.darkerGrey : TColors.darkGrey,
              child:const Icon(Iconsax.minus,color: Colors.white,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("3",style: Theme.of(context).textTheme.titleMedium,),
            ),
            CircleAvatar(
              radius: 18,
              backgroundColor: isdark ? TColors.darkerGrey : TColors.darkGrey,
              child:const Icon(Iconsax.add,color: Colors.white,),
            ),
            const Spacer(),
            ElevatedButton(style:ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
                onPressed: (){}, child:const Text("Add to Cart") )
          ],
        ),
      ),
    );
  }
}
