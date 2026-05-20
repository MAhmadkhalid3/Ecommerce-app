import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/features/shop/controller/CategoryController.dart';
import 'package:ecommerce/features/shop/controller/user-controller.dart';
import 'package:ecommerce/features/shop/screens/Cart/cart_screen.dart';
import 'package:ecommerce/features/shop/screens/product_detail/product_detail_screen.dart';
import 'package:ecommerce/utils/popups/shmiled_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/customShapes/curves_edges.dart';
import '../../../../common/widgets/home_Widgets/seachContainer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../authentication/controllers/banner_controller.dart';
import '../../controller/homeController.dart';
import '../../controller/product_controller.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Homecontroller());

    final productController = Get.find<ProductController>();

    bool isdark = THelperFunction.isDrak(context);
    double height = THelperFunction.ScreenHeight(context);

    // 🔥 Load products once
    productController.fetchProductsForCategory('shoes');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// ================= HEADER =================
            Stack(
              children: [
                ClipPath(
                  clipper: TCustomCurvedEdges(),
                  child: Container(
                    height: height * 0.44,
                    color: TColors.primary,
                  ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * .03,
                        left: TSizes.defaultSpace(context),
                        right: TSizes.defaultSpace(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: height * .016),

                          const Greeting_Bell(),

                          SizedBox(height: height * .029),

                          TSearchContainer(
                            text: "Search in store",
                            icon: Iconsax.search_normal,
                            txtColor: isdark ? Colors.white : Colors.black,
                            showBackground: false,
                            color: isdark
                                ? Colors.black.withOpacity(.78)
                                : Colors.white,
                          ),

                          SizedBox(height: height * .028),

                          const Popular_txt(),

                          SizedBox(height: height * .01),
                        ],
                      ),
                    ),

                    CircularList(height: height),
                  ],
                ),
              ],
            ),

            /// ================= BODY =================
            Padding(
              padding: EdgeInsets.only(
                left: TSizes.defaultSpace(context),
                right: TSizes.defaultSpace(context),
              ),
              child: Column(
                children: [

                  ScrollBanner(),

                  const SizedBox(height: 10),

                  /// ================= PRODUCT GRID =================
                  Obx(() {
                    final products =
                        productController.productsByCategory['shoes'] ?? [];

                    if (products.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 260,
                      ),
                      itemBuilder: (context, index) {
                        final p = products[index]; // 🔥 REAL DATA

                        return TProductCardVertical(
                          isdark: isdark,
                          product: p,
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
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
    required this.product,
  });

  final bool isdark;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailScreen(
          product: product,
        ));
      },
      child: Container(
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
          mainAxisSize: MainAxisSize.min,
          children: [

            /// ================= IMAGE + DISCOUNT =================
            Container(
              decoration: BoxDecoration(
                color: isdark ? TColors.darkGrey : TColors.darkerGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(7),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// DISCOUNT
                      if (product.salePrice < product.price)
                        Container(
                          padding: const EdgeInsets.only(
                              left: 6, right: 6, top: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${(((product.price - product.salePrice) / product.price) * 100).toInt()}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                      else
                        const SizedBox(),

                      const Icon(Icons.favorite, color: Colors.red),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// IMAGE
                  Image.network(
                    product.thumbnail,
                    height: 110,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// ================= TITLE =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 0),
              child: Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 3),

            /// ================= BRAND =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TBrandIconWithVerificationTitle(
                isdark: isdark,
                text: product.brand.name,
                IconSize: 16,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 5),

            /// ================= PRICE =================
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// PRICE
                  Text(
                    product.salePrice < product.price
                        ? '\$${product.salePrice}  (\$${product.price})'
                        : '\$${product.price}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),

                  /// ADD BUTTON
                  InkWell(
                    onTap: () {
                      // TODO: Add to cart logic
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
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

class TBrandIconWithVerificationTitle extends StatelessWidget {
  const TBrandIconWithVerificationTitle({
    super.key,
    required this.isdark,
    required this.text,
    required this.IconSize,
    required this.fontSize,
  });

  final bool isdark;
  final String text;
  final double IconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: isdark ? TColors.grey : Colors.grey.shade800,
              fontSize: fontSize),
        ),
        const SizedBox(width: 4),
        Icon(Icons.verified, size: IconSize, color: Colors.blue),
      ],
    );
  }
}

class ScrollBanner extends StatelessWidget {
  const ScrollBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final height = THelperFunction.ScreenHeight(context);
    final width = THelperFunction.ScreenWidth(context);

    final controller = Get.put(BannerController());

    return Obx(() {
      // --- Loading State
      if (controller.isLoading.value) {
        return TShimmerEffect(height: height *0.19,width: width*0.82,);
      }

      // --- Empty State
      if (controller.banners.isEmpty) {
        return  SizedBox(
          height: 200,
          child: Center(
            child: Text('No banners available',style: Theme.of(context).textTheme.headlineMedium,),
          ),
        );
      }

      // --- Banners Loaded
      return Column(
        children: [
          CarouselSlider(
            items: controller.banners
                .map((banner) => CRounded_Image(
              imageUrl: banner.imageUrl, // ✅ Network URL
            ))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) {
                controller.updatePageIndicator(index); // ✅ BannerController ka method
              },
            ),
          ),

          // --- Page Indicator Dots
          Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.banners.length,
                    (i) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 5,
                    width: 20,
                    decoration: BoxDecoration(
                      color: controller.carousalCurrentIndex.value == i
                          ? TColors.primary
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}



class CRounded_Image extends StatelessWidget {
  const CRounded_Image({
    super.key,
    this.imagePath,
    this.imageUrl,
  }) : assert(imagePath != null || imageUrl != null,
  'imagePath ya imageUrl mein se ek zaroori hai');

  final String? imagePath;  // Local asset
  final String? imageUrl;   // Network image

  @override
  Widget build(BuildContext context) {
    final resolved = imageUrl ?? imagePath ?? '';
    final isNetwork = resolved.startsWith('http://') || resolved.startsWith('https://');
    return Padding(
      padding: EdgeInsets.all(TSizes.defaultSpace(context) / 2.8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg(context)),
        child: isNetwork
            ? CachedNetworkImage(
                imageUrl: resolved,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade200,
                  child: const Center(child: SizedBox()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              )
            : Image.asset(
                resolved,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
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
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: THelperFunction.isDrak(context) ? Colors.black : Colors.white),
      textScaleFactor: 1.0,
    );
  }
}
class CircularList extends StatelessWidget {
  const CircularList({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    // ✅ Get.find() — controller pehle se AuthBinding ya main mein register hona chahiye
    final controller = Get.put(CategoryController());
    final height = MediaQuery.of(context).size.height;
    final isDark = THelperFunction.isDrak(context);
    print(controller.featuredCategories.length);

    return SizedBox(
      height: height * .14,
      child: Obx(() {
        // ✅ Loading state — shimmer list
        if (controller.isLoading.value) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: TSizes.defaultSpace(context)),
            itemCount: 6, // shimmer ke liye fixed count
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Container(width: height * .079, height: height * .079,decoration: BoxDecoration(shape: BoxShape.circle,),
                      child: ClipOval(child: TShimmerEffect(width: height * .079, height: height * .079))),
                  SizedBox(height: TSizes.spaceBtwItems(context) / 2),
                  TShimmerEffect(width: height * .08, height: height*.017),
                ],
              ),
            ),
          );
        }

        // ✅ Real data — featuredCategories se
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: TSizes.defaultSpace(context)),
          itemCount: controller.featuredCategories.length,
          itemBuilder: (_, index) {
            final category = controller.featuredCategories[index];
            final img = category.image;
            final isNetwork = img.startsWith('http://') || img.startsWith('https://');
            return Column(
              children: [
                Container(
                  width: height * .079,
                  height: height * .079,
                  margin: const EdgeInsets.only(right: 12),
                  padding:  EdgeInsets.all(height*.02),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black87 : Colors.white,
                    borderRadius: BorderRadius.circular(200),
                  ),
                  // ✅ Real image from Firestore
                  child: SizedBox(  width: height * .024,
                    height: height * .024,
                    child: isNetwork
                        ? CachedNetworkImage(
                            color: isDark ? Colors.white : Colors.black87,
                            imageUrl: img,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(child: SizedBox()),
                            errorWidget: (context, url, error) => Text(
                              "NO Categories Fatched ",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          )
                        : Image.asset(
                            img,
                            color: isDark ? Colors.white : Colors.black87,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems(context) / 9),
                SizedBox(
                  width: height * .09,
                  child: Center(
                    child: Text(
                      category.name, // ✅ Real name
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium?.apply( color: isDark ? Colors.black87 : Colors.white)
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
class Greeting_Bell extends StatelessWidget {
  const Greeting_Bell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good day of Shopping",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.labelSmall?.apply(
                  color: THelperFunction.isDrak(context)
                      ? Colors.black.withOpacity(.7)
                      : Colors.grey.shade300),
            ),
            SizedBox(
              height: TSizes.spaceBtwItems(context) / 7,
            ),
            Obx(
              () => controller.isloading.value
                  ? TShimmerEffect(width: 80, height: 16)
                  : Text(
                      controller.user.value.firstName.toString(),
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headlineSmall?.apply(
                          color: THelperFunction.isDrak(context)
                              ? Colors.black.withOpacity(.9)
                              : Colors.white),
                    ),
            )
          ],
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ));
            },
            child: CountBadgeCart(
              color:
                  THelperFunction.isDrak(context) ? Colors.black : Colors.white,
            ))
      ],
    );
  }
}

class CountBadgeCart extends StatelessWidget {
  final Color? color;
  const CountBadgeCart({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 50,
        width: 40,
        child: Icon(
          Iconsax.shopping_bag,
          size: 24,
          color: color ?? Colors.white,
        ),
      ),
      const Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 8,
            child: Text(
              "2",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ))
    ]);
  }
}
