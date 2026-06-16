

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/widgets/home_Widgets/custom_appbar.dart';
import '../../../common/widgets/t_sortable_product.dart';
import '../../../utils/constants/sizes.dart';
import '../controller/all_product_controller.dart';
import '../models/product_model.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    return Scaffold(
      appBar: TAppBar(title: Text("Brand"), showBackArrow: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace(context)),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              controller.products.assignAll(snapshot.data!);
              return const TSortableProducts();
            },
          ),
        ),
      ),
    );
  }
}