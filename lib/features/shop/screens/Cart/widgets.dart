import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/features/shop/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../home/home.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.isdark,
    required this.item,
  });

  final bool isdark;
  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;
    final subtitle = item.variationLabel;

    return Row(
      children: [
        ImageConatainer(isdark: isdark, imageUrl: item.displayImage),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandIconWithVerificationTitle(
                isdark: isdark,
                text: item.product.brand.name,
                IconSize: 10,
                fontSize: 10,
              ),
              Text(
                item.displayTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              IncreDecreButtonWithPriceTag(
                isdark: isdark,
                quantity: item.quantity,
                price: item.totalPrice,
                onDecrease: () => cart.decreaseQuantity(item.id),
                onIncrease: () => cart.increaseQuantity(item.id),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => cart.removeFromCart(item.id),
          icon: const Icon(Iconsax.trash, color: Colors.red),
        ),
      ],
    );
  }
}

class IncreDecreButtonWithPriceTag extends StatelessWidget {
  const IncreDecreButtonWithPriceTag({
    super.key,
    required this.isdark,
    required this.quantity,
    required this.price,
    required this.onDecrease,
    required this.onIncrease,
  });

  final bool isdark;
  final int quantity;
  final double price;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onDecrease,
          child: CircleAvatar(
            radius: 18,
            backgroundColor:
                isdark ? TColors.darkGrey.withOpacity(.8) : TColors.grey,
            child: const Icon(Iconsax.minus, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '$quantity',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        GestureDetector(
          onTap: onIncrease,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: isdark ? TColors.darkerGrey : TColors.primary,
            child: const Icon(Iconsax.add, color: Colors.white),
          ),
        ),
        const SizedBox(width: 12),
        Text('\$${price.toStringAsFixed(2)}'),
      ],
    );
  }
}

class ImageConatainer extends StatelessWidget {
  const ImageConatainer({
    super.key,
    required this.isdark,
    required this.imageUrl,
  });

  final bool isdark;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isdark ? TColors.darkGrey : TColors.light,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 55,
      width: 55,
      clipBehavior: Clip.antiAlias,
      child: imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            )
          : Image.asset('assets/images/products/NikeAirJOrdonBlackRed.png'),
    );
  }
}
