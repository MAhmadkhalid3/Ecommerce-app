import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/common/widgets/home_Widgets/seachContainer.dart';
import 'package:ecommerce/data/repositories/product_repository.dart';
import 'package:ecommerce/features/shop/controller/CategoryController.dart';
import 'package:ecommerce/features/shop/controller/product_controller.dart';
import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:ecommerce/features/shop/screens/shop/widgets.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/shmiled_loader.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {

    final controllers = Get.put(ProductRepository());
    final controller = Get.put(CategoryController());
    bool isdark = THelperFunction.isDrak(context);

    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          appBar: TAppBar(
            showBackArrow: false,
            title: const Text(
              "Shop",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            actions: [
              InkWell(onTap: () async { print("hemlooo");},
                child: CountBadgeCart(
                  color: isdark ? Colors.white : Colors.black,
                ),
              )
            ],
          ),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.featuredCategories.isEmpty) {
        return Scaffold(
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
          body: const Center(child: Text('No categories found')),
        );
      }

      return DefaultTabController(
        length: controller.featuredCategories.length,
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
                            ontab: () {},
                            text: 'Featured Brands',
                            fontsize: 19,
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
                      preferredSize: const Size.fromHeight(63),
                      child: Container(
                        color: THelperFunction.isDrak(context)
                            ? const Color(0xFF272727)
                            : Colors.white,
                        child: TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 12),
                          tabs: controller.featuredCategories.map((category) {
                            return Tab(text: category.name);
                          }).toList(),
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
                padding: EdgeInsets.all(TSizes.defaultSpace(context)),
                child: TabBarView(
                  children: controller.featuredCategories
                      .map(
                        (category) => CategoryProductsTab(
                          categoryId: category.id,
                          isdark: isdark,
                        ),
                      )
                      .toList(),
                ),
              ),
          ),
        ),
      );
    });
  }
}

class CategoryProductsTab extends StatefulWidget {
  final String categoryId;
  final bool isdark;

  const CategoryProductsTab({
    super.key,
    required this.categoryId,
    required this.isdark,
  });

  @override
  State<CategoryProductsTab> createState() => _CategoryProductsTabState();
}

class _CategoryProductsTabState extends State<CategoryProductsTab> {
  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    productController.fetchProductsForCategory(widget.categoryId);
  }

  bool _isNetwork(String s) =>
      s.startsWith('http://') || s.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products =
          productController.productsByCategory[widget.categoryId] ?? const [];

      if (true&& products.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (products.isEmpty) {
        return const Center(child: Text('No products found'));
      }

      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 250,
        ),
        itemBuilder: (_, index) {
          final p = products[index];
          final img = p.thumbnail;
          return _ProductCard(
            isdark: widget.isdark,
            title: p.title,
            brand: p.brand.name,
            price: p.salePrice ?? p.price,
            discountPercent: p.stock,
            image: img,
            imageIsNetwork: _isNetwork(img),
          );
        },
      );
    });
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.isdark,
    required this.title,
    required this.brand,
    required this.price,
    required this.image,
    required this.imageIsNetwork,
    this.discountPercent,
  });

  final bool isdark;
  final String title;
  final String brand;
  final double price;
  final String image;
  final bool imageIsNetwork;
  final int? discountPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: TColors.darkGrey,
            blurRadius: 1,
            offset: Offset(.5, .5),
          )
        ],
        borderRadius: BorderRadius.circular(20),
        color: isdark ? const Color(0xFF1C1C1C) : TColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isdark ? TColors.darkGrey : TColors.darkerGrey,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (discountPercent != null)
                      Container(
                        padding: const EdgeInsets.only(left: 6, right: 6, top: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$discountPercent%',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    const Icon(Icons.favorite, color: Colors.red),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 110,
                  child: image.isEmpty
                      ? const Center(child: Icon(Icons.image_not_supported))
                      : (imageIsNetwork
                      ? CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const TShimmerEffect(
                      width: 110,
                      height: 110,
                      radius: 12,
                    ),
                    errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.broken_image)),
                  )
                      : Image.asset(image, fit: BoxFit.contain)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              brand,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isdark ? TColors.grey : Colors.grey.shade800,
                fontSize: 14,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 5, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
