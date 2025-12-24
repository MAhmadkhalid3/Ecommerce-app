import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import '../home/home.dart';
class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: false,
        title: Text(
          "Wish List",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        actions: [
         Icon(Icons.add)

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace(context)),
        child:  GridView.builder(physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 250,
            ),
            itemBuilder: (context, index) {
              return TProductCardVertical(isdark: THelperFunction.isDrak(context));
            }),),
      ),
    );
  }
}
