import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/common/widgets/home_Widgets/seachContainer.dart';
import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:ecommerce/features/shop/screens/shop/widgets.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    bool isdark = THelperFunction.isDrak(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: TAppBar(
            showBackArrow: false,
            title: const Text(
              "Shop",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            actions: [
              CountBadgeCart(
                color: isdark ? Colors.white : Colors.black,
              )
            ],
          ),

          // Main Body with scroll behavior
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 340,
                    toolbarHeight: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: isdark ? TColors.black : Colors.white,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: TSizes.defaultSpace(context),
                        right: TSizes.defaultSpace(context),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const SizedBox(
                            height: 7,
                          ),

                          /// Search bar
                          const TSearchContainer(
                            icon: Iconsax.search_normal,
                            text: "Search in store",
                            showBackground: true,
                          ),
                          SizedBox(height: TSizes.spaceBtwSections(context)),

                          /// Featured Brands
                          FeaturedBrandHeading(
                            ontab: () {}, text: 'Featured Brands',fontsize: 19,
                          ),
                          SizedBox(height: TSizes.spaceBtwItems(context)),
                          SizedBox(
                            height:
                                THelperFunction.ScreenHeight(context) * .163,
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 145,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(
                                      TSizes.cardRadiusLg(context),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(FontAwesomeIcons.shirt),
                                      SizedBox(
                                        width: 60,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Nike',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(width: 4),
                                                Icon(Icons.verified,
                                                    size: 16,
                                                    color: Colors.blue),
                                              ],
                                            ),
                                            Text(
                                              "519 Products Listed",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: Container(
                        color: THelperFunction.isDrak(context)
                            ? const Color(0xFF272727)
                            : Colors.white,
                        child: TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelPadding: const EdgeInsets.symmetric(vertical: 7,horizontal: 12),
                          tabs: const [
                            Text("Sports"),
                            Text("Forniture"),
                            Text("Electronics"),
                            Text("Cloths"),
                            Text("Cosmetics")
                          ],
                          indicatorColor: TColors.primary,
                          unselectedLabelColor: TColors.darkGrey,
                          labelColor: THelperFunction.isDrak(context)
                              ? TColors.white
                              : TColors.primary,
                        ),
                      ),
                    ),
                  ),
                ];
              },

              /// Main Scrollable Body
              body: Padding(
                padding: EdgeInsets.all(
                     TSizes.defaultSpace(context)),
                child: TabBarView(children: [
                  ListView(shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:[ Column(
                      children: [
                        Container(padding: EdgeInsets.all(TSizes.spaceBtwItems(context)),
                            decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(
                            TSizes.cardRadiusLg(context),
                          ),
                        ),
                        child: Column(
                          children: [ const SizedBox(height: 10),
                            Row(

                              children: [
                                const Icon(FontAwesomeIcons.shirt),
                                const SizedBox(width: 16,),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nike',
                                          overflow:
                                          TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.w700),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.verified,
                                            size: 16,
                                            color: Colors.blue),
                                      ],
                                    ),
                                    Text(
                                      "512 Products",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            const Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                              ],)
                          ],
                        ) ,

                        ),
                       const  SizedBox(height: 10,),
                        FeaturedBrandHeading(text: "you might like",
                          ontab: () {}, fontsize: 14,
                        ),
                       const SizedBox(height: 10,),
                        GridView.builder(physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 6,
                            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent: 250,
                            ),
                            itemBuilder: (context, index) {
                              return TProductCardVertical(isdark: isdark);
                            }),
                      ],
                    ),
                  ]), ListView(shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children:[ Column(
                        children: [
                          Container(padding: EdgeInsets.all(TSizes.spaceBtwItems(context)),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(
                                TSizes.cardRadiusLg(context),
                              ),
                            ),
                            child: Column(
                              children: [ const SizedBox(height: 10),
                                Row(

                                  children: [
                                    const Icon(FontAwesomeIcons.shirt),
                                    const SizedBox(width: 16,),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nike',
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(Icons.verified,
                                                size: 16,
                                                color: Colors.blue),
                                          ],
                                        ),
                                        Text(
                                          "512 Products",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                const Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                  ],)
                              ],
                            ) ,

                          ),
                          const  SizedBox(height: 10,),
                          FeaturedBrandHeading(text: "you might like",
                            ontab: () {}, fontsize: 14,
                          ),
                          const SizedBox(height: 10,),
                          GridView.builder(physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 6,
                              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) {
                                return TProductCardVertical(isdark: isdark);
                              }),
                        ],
                      ),
                      ]), ListView(shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children:[ Column(
                        children: [
                          Container(padding: EdgeInsets.all(TSizes.spaceBtwItems(context)),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(
                                TSizes.cardRadiusLg(context),
                              ),
                            ),
                            child: Column(
                              children: [ const SizedBox(height: 10),
                                Row(

                                  children: [
                                    const Icon(FontAwesomeIcons.shirt),
                                    const SizedBox(width: 16,),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nike',
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(Icons.verified,
                                                size: 16,
                                                color: Colors.blue),
                                          ],
                                        ),
                                        Text(
                                          "512 Products",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                const Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                  ],)
                              ],
                            ) ,

                          ),
                          const  SizedBox(height: 10,),
                          FeaturedBrandHeading(text: "you might like",
                            ontab: () {}, fontsize: 14,
                          ),
                          const SizedBox(height: 10,),
                          GridView.builder(physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 6,
                              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) {
                                return TProductCardVertical(isdark: isdark);
                              }),
                        ],
                      ),
                      ]), ListView(shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children:[ Column(
                        children: [
                          Container(padding: EdgeInsets.all(TSizes.spaceBtwItems(context)),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(
                                TSizes.cardRadiusLg(context),
                              ),
                            ),
                            child: Column(
                              children: [ const SizedBox(height: 10),
                                Row(

                                  children: [
                                    const Icon(FontAwesomeIcons.shirt),
                                    const SizedBox(width: 16,),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nike',
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(Icons.verified,
                                                size: 16,
                                                color: Colors.blue),
                                          ],
                                        ),
                                        Text(
                                          "512 Products",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                const Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                  ],)
                              ],
                            ) ,

                          ),
                          const  SizedBox(height: 10,),
                          FeaturedBrandHeading(text: "you might like",
                            ontab: () {}, fontsize: 14,
                          ),
                          const SizedBox(height: 10,),
                          GridView.builder(physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 6,
                              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) {
                                return TProductCardVertical(isdark: isdark);
                              }),
                        ],
                      ),
                      ]), ListView(shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children:[ Column(
                        children: [
                          Container(padding: EdgeInsets.all(TSizes.spaceBtwItems(context)),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(
                                TSizes.cardRadiusLg(context),
                              ),
                            ),
                            child: Column(
                              children: [ const SizedBox(height: 10),
                                Row(

                                  children: [
                                    const Icon(FontAwesomeIcons.shirt),
                                    const SizedBox(width: 16,),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nike',
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(Icons.verified,
                                                size: 16,
                                                color: Colors.blue),
                                          ],
                                        ),
                                        Text(
                                          "512 Products",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                const Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                    ProductPicContainer(image: 'assets/images/products/leather_jacket_3.png',),
                                  ],)
                              ],
                            ) ,

                          ),
                          const  SizedBox(height: 10,),
                          FeaturedBrandHeading(text: "you might like",
                            ontab: () {}, fontsize: 14,
                          ),
                          const SizedBox(height: 10,),
                          GridView.builder(physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 6,
                              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) {
                                return TProductCardVertical(isdark: isdark);
                              }),
                        ],
                      ),
                      ]),
                ]),
              ))),
    );
  }
}

class ProductPicContainer extends StatelessWidget {
 final String image;
   const ProductPicContainer({

    super.key, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container( padding: const EdgeInsets.all(4),
    height: 80,width: 72,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              color: THelperFunction.isDrak(context)?TColors.darkGrey: TColors.light,
                              ),child: Image.asset(image),
                              );
  }
}
