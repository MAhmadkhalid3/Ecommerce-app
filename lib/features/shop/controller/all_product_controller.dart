import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/repositories/product_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/product_model.dart';
class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxString selectedSort = 'Name'.obs; // ✅

  // ✅ Sorting function
  void sortProducts(String sortOption) {
    selectedSort.value = sortOption;
    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Sale':
        products.sort((a, b) => b.salePrice.compareTo(a.salePrice));
        break;
      case 'Newest':
        products.sort((a, b) => (b.createdAt ?? Timestamp(0, 0))
            .compareTo(a.createdAt ?? Timestamp(0, 0)));
        break;
      case 'Popularity':
        products.sort((a, b) => b.stock.compareTo(a.stock));
        break;
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final products = await repository.fetchProductsByQuery(query);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}