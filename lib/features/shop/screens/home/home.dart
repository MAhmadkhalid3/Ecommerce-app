import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/features/shop/screens/Cart/cart_screen.dart';
import 'package:ecommerce/features/shop/screens/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/customShapes/curves_edges.dart';
import '../../../../common/widgets/home_Widgets/seachContainer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controller/homeController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Homecontroller());
    bool isdark = THelperFunction.isDrak(context);
    double height = THelperFunction.ScreenHeight(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header

            Stack(
              children: [
                ClipPath(
                  clipper: TCustomCurvedEdges(),
                  child: Container(
                    height: THelperFunction.ScreenHeight(context) * 0.44,
                    color: TColors.primary,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * .03,
                          left: TSizes.defaultSpace(context),
                          right: TSizes.defaultSpace(context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height:
                                THelperFunction.ScreenHeight(context) * .016,
                          ),
                          // 👋 Greeting & Bell
                          const Greeting_Bell(),
                          SizedBox(height: height * .029),

                          // 🔍 Search Bar
                          TSearchContainer(
                            text: "Search in store",
                            icon: Iconsax.search_normal,txtColor: THelperFunction.isDrak(context)?Colors.white:Colors.black,
                            showBackground: false,color: THelperFunction.isDrak(context)? Colors.black.withOpacity(.78):Colors.white,
                          ),

                          SizedBox(height: height * .028),
                          // ⭐ Popular Categories
                          const Popular_txt(),
                          SizedBox(height: height * .01),

                          // 🔘 Circle List
                        ],
                      ),
                    ),
                    Circular_list(height: height)
                  ],
                ),
              ],
            ),

            /// Body

            Padding(
              padding: EdgeInsets.only(
                  left: TSizes.defaultSpace(context),
                  right: TSizes.defaultSpace(context)),
              child: Column(children: [
                /// ------------- Scroll Banner ------------------
                ScrollBanner(controller: controller),

                /// ------------- GRid box pic with price -----------
                GridView.builder(physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      mainAxisExtent: 250,
                    ),
                    itemBuilder: (context, index) {
                      return TProductCardVertical(isdark: isdark);
                    }),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({
    super.key,
    required this.isdark,
  });

  final bool isdark;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => const ProductDetailScreen() ,));},
      child: Container(
        width: 190,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: TColors.darkGrey, blurRadius: 1, offset: Offset(.5, .5))
          ],
          borderRadius: BorderRadius.circular(20),
          color: isdark ? const Color(0xFF1C1C1C) : TColors.white, // Bottom background
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Upper part
            Container(
              decoration: BoxDecoration(
                color: isdark ? TColors.darkGrey: TColors.darkerGrey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),

              /// Vertical OBx For Grid

              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 6,right: 6, top:  4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '78%',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      const Icon(Icons.favorite, color: Colors.red),
                    ],
                  ),

                  Center(
                    child: Image.asset(
                      'assets/images/products/nike-shoes.png',
                      height: 110,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Product title and brand

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Green Nike sports shoe',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TBrandIconWithVerificationTitle( isdark: isdark, text: 'Nike',IconSize: 16, fontSize: 16,),
            ),

            const SizedBox(height: 5),

            // Price and button
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '\$0.0 - \$122.6',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),
                  ),
                  InkWell( onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TBrandIconWithVerificationTitle extends StatelessWidget {
  const TBrandIconWithVerificationTitle({
    super.key,
    required this.isdark, required this.text, required this.IconSize, required this.fontSize,
  });

  final bool isdark;
  final String text;
  final double IconSize ;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: isdark ? TColors.grey : Colors.grey.shade800,fontSize: fontSize),
        ),
        const SizedBox(width: 4),
        Icon(Icons.verified, size:IconSize, color: Colors.blue),
      ],
    );
  }
}

class ScrollBanner extends StatelessWidget {
  const ScrollBanner({
    super.key,
    required this.controller,
  });

  final Homecontroller controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            items: const [
              CRounded_Image(
                ImagePath: "assets/images/banners/banner_3.jpg",
              ),
              CRounded_Image(
                ImagePath: "assets/images/banners/banner_4.jpg",
              ),
              CRounded_Image(
                ImagePath: "assets/images/banners/banner_5.jpg",
              ),
            ],
            options: CarouselOptions(
              onPageChanged: (inde, _) {
                controller.updateCurserIndicator(inde);
              },
              viewportFraction: 1,
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 5,
                        width: 20,
                        decoration: BoxDecoration(
                          color: controller.currentIndex == i
                              ? TColors.primary
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CRounded_Image extends StatelessWidget {
  const CRounded_Image({
    super.key,
    required this.ImagePath,
  });
  final String ImagePath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TSizes.defaultSpace(context) / 2.8),
      child: Container(
        margin: const EdgeInsets.only(left: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg(context))),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg(context)),
            child: Image.asset(
              ImagePath,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}

class Popular_txt extends StatelessWidget {
  const Popular_txt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Popular Categories",
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600,color: THelperFunction.isDrak(context)?Colors.black:Colors.white ),
      textScaleFactor: 1.0,
    );
  }
}

class Circular_list extends StatelessWidget {
  const Circular_list({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * .14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: TSizes.defaultSpace(context)),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(children: [
            Container(
              width: height * .079, height: height * .079,
              margin: const EdgeInsets.only(right: 12), // keep margin if needed
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: THelperFunction.isDrak(context)?Colors.black87:Colors.white,
                borderRadius: BorderRadius.circular(200),
              ),
              child:  Icon(Icons.shop, size: 28, color:  THelperFunction.isDrak(context)?Colors.white:Colors.black),
            ),
            SizedBox(
              height: TSizes.spaceBtwItems(context) / 2,
            ),
            SizedBox(
                width: height * .09,
                child: Text(
                  "TV of stylo",
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(color:  THelperFunction.isDrak(context)?Colors.black:Colors.white ),

                ))
          ]);
        },
      ),
    );
  }
}

class Greeting_Bell extends StatelessWidget {
  const Greeting_Bell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "Good day of Shopping",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.apply(color: THelperFunction.isDrak(context)? Colors.black.withOpacity(.7): Colors.grey.shade300),
            ),
            SizedBox(
              height: TSizes.spaceBtwItems(context) / 7,
            ),
            Text(
              "M.Ahmad",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.apply(color: THelperFunction.isDrak(context)? Colors.black.withOpacity(.9): Colors.white),
            )
          ],
        ),
        InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen(),));},child: CountBadgeCart(color: THelperFunction.isDrak(context)?Colors.black:Colors.white,))
      ],
    );
  }
}

class CountBadgeCart extends StatelessWidget {
  final Color? color;
  const CountBadgeCart({
    super.key,  this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ SizedBox( height: 50,width: 40,
        child: Icon(
          Iconsax.shopping_bag,
          size: 24,
          color: color ??Colors.white,
        ),
      ),
      const Positioned(top: 0,right: 0,child: CircleAvatar(backgroundColor: Colors.red,radius: 8,child: Text("2",style: TextStyle(fontSize: 12,color: Colors.white),),))]
    );
  }
}
