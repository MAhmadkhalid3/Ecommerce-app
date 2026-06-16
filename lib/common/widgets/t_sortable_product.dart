import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/shop/screens/home/home.dart';
import '../../utils/constants/sizes.dart';
import 'package:get/get.dart';
import '../../features/shop/controller/all_product_controller.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllProductsController>();

    return Obx(() => Column(
          children: [
            /// Dropdown
            DropdownButtonFormField(
              value: controller.selectedSort.value,
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
              onChanged: (value) {
                if (value != null) controller.sortProducts(value);
              },
              items: [
                'Name',
                'Higher Price',
                'Lower Price',
                'Sale',
                'Newest',
                'Popularity'
              ]
                  .map((option) =>
                      DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
            ),
            SizedBox(height: TSizes.spaceBtwSections(context)),

            /// Products
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 268,
              ),
              itemBuilder: (context, index) {
                return TProductCardVertical(
                  isdark: THelperFunction.isDrak(context),
                  product: controller.products[index],
                );
              },
            ),
          ],
        ));
  }
}
