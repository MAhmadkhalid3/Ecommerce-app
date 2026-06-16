import 'package:ecommerce/features/shop/controller/wishlist_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistHeartButton extends StatelessWidget {
  const WishlistHeartButton({
    super.key,
    required this.product,
    this.iconSize = 22,
  });

  final ProductModel product;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistController.instance;

    return Obx(() {
      final inWishlist = wishlist.isInWishlist(product.id);
      return InkWell(
        onTap: () => wishlist.toggleWishlist(product),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            inWishlist ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: iconSize,
          ),
        ),
      );
    });
  }
}
