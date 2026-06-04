import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/customShapes/curves_edges.dart';
import 'package:ecommerce/features/shop/controller/cart_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/product_detail/widgets.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:ecommerce/utils/popups/shmiled_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../common/widgets/home_Widgets/custom_appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../home/home.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String selectedImage;
  String selectedSize = '';
  List<String> availableSizes = [];
  ProductVariationModel? selectedVariation;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.product.images.first;
    _updateVariation(selectedImage);
  }

  void _updateVariation(String imageUrl) {
    final matched = widget.product.productVariations
        .where((v) => v.image == imageUrl)
        .toList();

    final sizes = matched
        .map((v) => v.attributeValues['Size']?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList();

    setState(() {
      selectedImage = imageUrl;
      selectedSize = '';
      availableSizes = sizes;
      selectedVariation = matched.isNotEmpty ? matched.first : null;
    });
  }

  void _onSizeSelected(String size) {
    final matched = widget.product.productVariations.firstWhereOrNull(
          (v) =>
      v.image == selectedImage &&
          v.attributeValues['Size']?.toString() == size,
    );
    setState(() {
      selectedSize = size;
      selectedVariation = matched;
    });
  }

  double get currentPrice =>
      selectedVariation != null ? selectedVariation!.price : widget.product.price;

  double get currentSalePrice =>
      selectedVariation != null ? selectedVariation!.salePrice : widget.product.salePrice;

  int get currentStock =>
      selectedVariation != null ? selectedVariation!.stock : widget.product.stock;

  bool get isInStock => currentStock > 0;

  @override
  Widget build(BuildContext context) {
    bool isdark = THelperFunction.isDrak(context);
    return SizedBox(
      child: Scaffold(
        bottomNavigationBar: TBottomAddToCart(
          product: widget.product,
          variation: selectedVariation,
          selectedSize: selectedSize.isNotEmpty ? selectedSize : null,
        ),
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
                    child: SizedBox(
                      height: 100,
                      width: 200,
                      child: CachedNetworkImage(
                        imageUrl: selectedImage,
                        // ── Shimmer for main image ──
                        placeholder: (context, url) => TShimmerEffect(
                          width: double.infinity,
                          height: 320,
                          radius: 0,
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image),
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),
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
                        padding: const EdgeInsets.only(left: 24),
                        itemBuilder: (BuildContext context, int index) {
                          return TRoundedImage(
                              onPressed: () => _updateVariation(
                                  widget.product.images[index]),
                              width: 50,
                              height: 100,
                              isNetworkImage: true,
                              border: Border.all(
                                color: selectedImage ==
                                    widget.product.images[index]
                                    ? TColors.primary
                                    : Colors.transparent,
                              ),
                              backgroundColor:
                              isdark ? Colors.grey.shade900 : TColors.white,
                              imageUrl: widget.product.images[index]);
                        },
                        separatorBuilder: (_, __) {
                          return const SizedBox(width: 10);
                        },
                        itemCount: widget.product.images.length,
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
                            child: const Icon(Iconsax.heart)))
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
                      // ── Rating Row ──
                      Row(
                        children: [
                          const Icon(Iconsax.star5,
                              color: Colors.amber, size: 24),
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
                                style:
                                Theme.of(context).textTheme.labelLarge),
                          ])),
                          const Spacer(),
                          const Icon(Icons.share, size: 24)
                        ],
                      ),
                      const SizedBox(height: 10),

                      // ── Price Tag (dynamic) ──
                      Row(
                        children: [
                          Container(
                            width: 35,
                            decoration: BoxDecoration(
                                color: TColors.secondary.withOpacity(.8),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  currentSalePrice > 0
                                      ? "${((1 - currentSalePrice / currentPrice) * 100).toStringAsFixed(0)}%"
                                      : "0%",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "\$${currentPrice.toStringAsFixed(0)}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "\$${currentSalePrice.toStringAsFixed(0)}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // ── Title ──
                      Text(
                        widget.product.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 3.2),

                      // ── Stock ──
                      Row(
                        children: [
                          Text("Stock",
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Text(
                            isInStock ? "In Stock" : "Out of Stock",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(
                                fontSizeDelta: 1.3,
                                color: isInStock
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      TBrandIconWithVerificationTitle(
                        isdark: isdark,
                        text: widget.product.brand.name,
                        IconSize: 10,
                        fontSize: 12,
                      ),
                      const SizedBox(height: 10),

                      // ── Variation Box (dynamic) ──
                      Container(
                        padding: EdgeInsets.all(TSizes.md(context)),
                        decoration: BoxDecoration(
                            color: isdark ? TColors.darkGrey : TColors.light,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Text("Variation",
                                style:
                                Theme.of(context).textTheme.titleLarge),
                            const SizedBox(width: 10),
                            // ── Shimmer jab variation null ho ──
                            selectedVariation == null && availableSizes.isEmpty
                                ? Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                TShimmerEffect(
                                    width: 150, height: 14, radius: 4),
                                const SizedBox(height: 6),
                                TShimmerEffect(
                                    width: 120, height: 14, radius: 4),
                                const SizedBox(height: 6),
                                TShimmerEffect(
                                    width: 100, height: 14, radius: 4),
                              ],
                            )
                                : Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Price:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    const SizedBox(width: 5),
                                    Text(
                                      "\$${currentPrice.toStringAsFixed(0)}",
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
                                      "\$${currentSalePrice.toStringAsFixed(0)}",
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
                                    const SizedBox(width: 5),
                                    Text(
                                      isInStock
                                          ? "In Stock ($currentStock)"
                                          : "Out of Stock",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .apply(
                                          fontWeightDelta: 1,
                                          color: isInStock
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ],
                                ),
                                if (selectedVariation != null)
                                  Row(
                                    children: [
                                      Text("SKU:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      const SizedBox(width: 5),
                                      Text(
                                        selectedVariation!.sku,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .apply(fontWeightDelta: 1),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // ── Sizes (dynamic + shimmer) ──
                      if (availableSizes.isEmpty && selectedVariation == null)
                      // Loading state — shimmer chips
                        Wrap(
                          spacing: 8,
                          children: List.generate(
                            3,
                                (i) => TShimmerEffect(
                                width: 60, height: 35, radius: 8),
                          ),
                        )
                      else if (availableSizes.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sizes",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              children: availableSizes
                                  .map((size) => TChoiceChip(
                                text: size,
                                selected: selectedSize == size,
                                onSelected: (_) =>
                                    _onSizeSelected(size),
                              ))
                                  .toList(),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),

                      // ── Checkout Button ──
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Center(child: Text("Checkout"))),
                      ),

                      // ── Description ──
                      Description(
                        title: 'Description',
                        discription: widget.product.description,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0),
                        child: Divider(),
                      ),

                      // ── Reviews ──
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Reviews(199)",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16))
                        ],
                      ),
                      const SizedBox(height: 30)
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
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        ReadMoreText(
          discription,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: "Show more",
          trimExpandedText: "Show less",
          moreStyle:
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
          lessStyle:
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}

class TBottomAddToCart extends StatefulWidget {
  const TBottomAddToCart({
    super.key,
    required this.product,
    this.variation,
    this.selectedSize,
  });

  final ProductModel product;
  final ProductVariationModel? variation;
  final String? selectedSize;

  @override
  State<TBottomAddToCart> createState() => _TBottomAddToCartState();
}

class _TBottomAddToCartState extends State<TBottomAddToCart> {
  int _pendingQty = 1;

  @override
  Widget build(BuildContext context) {
    final bool isdark = THelperFunction.isDrak(context);
    final cart = CartController.instance;

    return Obx(() {
      final cartItem = cart.getCartItem(
        widget.product,
        variation: widget.variation,
      );
      final displayQty = cartItem?.quantity ?? _pendingQty;

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
              GestureDetector(
                onTap: () {
                  if (cartItem != null) {
                    cart.decreaseQuantity(cartItem.id);
                  } else if (_pendingQty > 1) {
                    setState(() => _pendingQty--);
                  }
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      isdark ? TColors.darkerGrey : TColors.darkGrey,
                  child: const Icon(Iconsax.minus, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '$displayQty',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (cartItem != null) {
                    cart.increaseQuantity(cartItem.id);
                  } else {
                    setState(() => _pendingQty++);
                  }
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      isdark ? TColors.darkerGrey : TColors.darkGrey,
                  child: const Icon(Iconsax.add, color: Colors.white),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                ),
                onPressed: () {
                  cart.addToCart(
                    widget.product,
                    quantity: cartItem != null ? 1 : _pendingQty,
                    variation: widget.variation,
                    selectedSize: widget.selectedSize,
                  );
                },
                child: Text(cartItem != null ? 'Add More' : 'Add to Cart'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
