import 'package:get/get.dart';

import '../../../data/repositories/product_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts(); // ✅ only once
  }
  static ProductController get instance => Get.find();

  final RxString selectedImage = ''.obs;
  final RxString selectedSize = ''.obs;

  final RxList<String> availableSizes = <String>[].obs;

  // ✅ Featured products simple list
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  final RxMap<String, bool> loadingStates = <String, bool>{}.obs;

  final _repo = Get.put(ProductRepository());

  // ✅ Fetch featured products
  Future<void> fetchFeaturedProducts() async {
    try {
      loadingStates['featured'] = true;

      final products = await _repo.getIsFeaturedProduct();

      featuredProducts.assignAll(products);

    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    } finally {
      loadingStates['featured'] = false;
    }
  }

  // Image variation logic
  void onImageSelected(String imageUrl, List<ProductVariationModel> variations) {
    selectedImage.value = imageUrl;
    selectedSize.value = '';

    availableSizes.value = variations
        .where((v) => v.image == imageUrl)
        .map((v) => v.attributeValues['Size']?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList();
  }

  // Variation selection
  final Rx<ProductVariationModel?> selectedVariation = Rx<ProductVariationModel?>(null);
  final RxMap<String, String> selectedAttributes = <String, String>{}.obs;

  void onAttributeSelected(
      String attributeName,
      String value,
      List<ProductVariationModel> variations,
      ) {
    selectedAttributes[attributeName] = value;

    final matched = variations.firstWhereOrNull(
          (v) => selectedAttributes.entries.every(
            (entry) => v.attributeValues[entry.key] == entry.value,
      ),
    );

    selectedVariation.value = matched;
  }
}