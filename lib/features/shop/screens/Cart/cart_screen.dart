import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/screens/Cart/widgets.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isdark = THelperFunction.isDrak(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(TSizes.defaultSpace(context)),
          itemBuilder: (context, index) {
            return CartCard(isdark: isdark);
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
          itemCount: 5),
    );
  }
}


