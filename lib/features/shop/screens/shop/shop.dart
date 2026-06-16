import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/common/widgets/home_Widgets/seachContainer.dart';
import 'package:ecommerce/data/repositories/product_repository.dart';
import 'package:ecommerce/features/shop/controller/CategoryController.dart';
import 'package:ecommerce/features/shop/controller/product_controller.dart';
import 'package:ecommerce/features/shop/screens/Cart/cart_screen.dart';
import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:ecommerce/features/shop/screens/shop/widgets.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../authentication/controllers/brand_controller.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(ProductRepository());
    final controller = Get.put(CategoryController());
    final Brandcontroller = Get.put(BrandController());
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
              InkWell(
                onTap: () async {
                  print("hemlooo");
                },
                child: InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));},
                  child: CountBadgeCart(
                    color: isdark ? Colors.white : Colors.black,
                  ),
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
              InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));},
                child: CountBadgeCart(
                  color: isdark ? Colors.white : Colors.black,
                ),
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
              InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));},
                child: CountBadgeCart(
                  color: isdark ? Colors.white : Colors.black,
                ),
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
                  expandedHeight: 355,
                  toolbarHeight: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: isdark ? TColors.black : Colors.white,
                  flexibleSpace: Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 0,
                      left: TSizes.defaultSpace(context),
                      right: TSizes.defaultSpace(context),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 7),

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

                        // ✅ Obx bahar, GridView andar
                        Obx(() {
                          if (Brandcontroller.isLoading.value) {
                            return const TBrandShimmer(itemCount: 4);
                          }

                          if (Brandcontroller.allBrands.isEmpty) {
                            return const Center(child: Text('No brands found'));
                          }

                          return SizedBox(
                            height: THelperFunction.ScreenHeight(context) * .163,
                            child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: Brandcontroller.allBrands.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 145,
                              ),
                              itemBuilder: (context, index) {
                                return BrandCard(brand: Brandcontroller.allBrands[index]); // ✅
                              },
                            ),
                          );
                        }),
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
                          vertical: 0,
                          horizontal: 12,
                        ),
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
              padding: EdgeInsets.all(10),
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
    productController.featuredProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products = productController.featuredProducts;

      if (products.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 268,
        ),
        itemBuilder: (_, index) {
          final product = products[index];
          return TProductCardVertical(
            isdark: widget.isdark,
            product: product,
          );
        },
      );
    });
  }
}
