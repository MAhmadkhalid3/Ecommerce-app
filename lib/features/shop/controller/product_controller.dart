import 'package:get/get.dart';

import '../../../data/repositories/product_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final RxString selectedImage = ''.obs;
  final RxString selectedSize = ''.obs;

  void onImageSelected(String imageUrl, List<ProductVariationModel> variations) {
    selectedImage.value = imageUrl;
    selectedSize.value = ''; // reset size

    // Is image ki variations dhundo
    availableSizes.value = variations
        .where((v) => v.image == imageUrl)
        .map((v) => v.attributeValues['Size']?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList();
  }

  final RxList<String> availableSizes = <String>[].obs;

  final RxMap<String, List<ProductModel>> productsByCategory =
      <String, List<ProductModel>>{}.obs;

  final RxMap<String, bool> loadingStates = <String, bool>{}.obs;

  final _repo = Get.put(ProductRepository());

  Future<void> fetchProductsForCategory(String categoryId) async {
    try {
      /// Prevent duplicate API calls
      if (productsByCategory.containsKey(categoryId)) {
        return;
      }

      loadingStates[categoryId] = true;

      final products = await _repo.getProductsByCategory(
        categoryId: categoryId,
      );

      productsByCategory[categoryId] = products;
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    } finally {
      loadingStates[categoryId] = false;
    }
  }
  // ProductController mein add karo
  final Rx<ProductVariationModel?> selectedVariation = Rx(null);
  final RxMap<String, String> selectedAttributes = <String, String>{}.obs;

  void onAttributeSelected(String attributeName, String value, List<ProductVariationModel> variations) {
    selectedAttributes[attributeName] = value;

    // Match karo variation jo selected attributes se match kare
    final matched = variations.firstWhereOrNull((v) {
      return selectedAttributes.entries.every(
            (entry) => v.attributeValues[entry.key] == entry.value,
      );
    });

    selectedVariation.value = matched;
  }
}
