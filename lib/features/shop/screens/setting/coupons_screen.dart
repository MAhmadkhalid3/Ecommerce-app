import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class CouponModel {
  final String code;
  final String title;
  final String description;
  final String discount;
  final String validUntil;

  const CouponModel({
    required this.code,
    required this.title,
    required this.description,
    required this.discount,
    required this.validUntil,
  });
}

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  static const List<CouponModel> _coupons = [
    CouponModel(
      code: 'WELCOME10',
      title: 'Welcome Offer',
      description: '10% off on your first order above \$50',
      discount: '10% OFF',
      validUntil: '31 Dec 2026',
    ),
    CouponModel(
      code: 'SAVE20',
      title: 'Season Sale',
      description: 'Flat 20% off on selected Nike products',
      discount: '20% OFF',
      validUntil: '30 Sep 2026',
    ),
    CouponModel(
      code: 'FREESHIP',
      title: 'Free Shipping',
      description: 'Free delivery on orders above \$100',
      discount: 'FREE SHIP',
      validUntil: '31 Dec 2026',
    ),
    CouponModel(
      code: 'FLASH50',
      title: 'Flash Deal',
      description: '\$50 off when you spend \$200 or more',
      discount: '\$50 OFF',
      validUntil: '15 Aug 2026',
    ),
  ];

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    TLoaders.successSnackBar(
      title: 'Copied',
      message: 'Coupon code $code copied to clipboard.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDrak(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'My Coupons',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(TSizes.defaultSpace(context)),
        itemCount: _coupons.length,
        separatorBuilder: (_, __) =>
            SizedBox(height: TSizes.spaceBtwItems(context)),
        itemBuilder: (context, index) {
          final coupon = _coupons[index];
          return Card(
            elevation: 0,
            color: isDark ? TColors.darkGrey : TColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusMd(context)),
              side: BorderSide(
                color: isDark ? TColors.darkerGrey : TColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: TColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          coupon.discount,
                          style: const TextStyle(
                            color: TColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(Iconsax.discount_shape,
                          color: TColors.primary, size: 28),
                    ],
                  ),
                  SizedBox(height: TSizes.spaceBtwItems(context) / 2),
                  Text(
                    coupon.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(coupon.description),
                  const SizedBox(height: 8),
                  Text(
                    'Valid until: ${coupon.validUntil}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark
                                  ? TColors.darkerGrey
                                  : TColors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            coupon.code,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _copyCode(coupon.code),
                        child: const Text('Copy'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
