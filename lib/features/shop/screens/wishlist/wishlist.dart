import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/controller/wishlist_controller.dart';
import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistController.instance;
    final isDark = THelperFunction.isDrak(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: Text(
          'Wish List',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          Obx(() {
            if (wishlist.wishlistProducts.isEmpty) {
              return const SizedBox.shrink();
            }
            return IconButton(
              onPressed: () => _confirmClear(context),
              icon: const Icon(Iconsax.trash),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (wishlist.wishlistProducts.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.heart,
                    size: 72,
                    color: isDark ? Colors.white38 : Colors.black26,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems(context)),
                  Text(
                    'Your wishlist is empty',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap the heart on products to save them here.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(TSizes.defaultSpace(context)),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: wishlist.wishlistProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 250,
            ),
            itemBuilder: (context, index) {
              return TProductCardVertical(
                isdark: isDark,
                product: wishlist.wishlistProducts[index],
              );
            },
          ),
        );
      }),
    );
  }

  void _confirmClear(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear wishlist'),
        content: const Text('Remove all items from your wishlist?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              WishlistController.instance.clearWishlist();
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
