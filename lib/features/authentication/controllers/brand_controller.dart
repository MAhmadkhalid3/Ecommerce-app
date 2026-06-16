import 'package:get/get.dart';

import '../../../data/repositories/brand-repository.dart';
import '../../../utils/popups/loaders.dart';
import '../../personalization/models/brand_modal.dart';


class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  // Variables
  final isLoading = false.obs;
  final RxList<BrandModal> allBrands = <BrandModal>[].obs;
  final RxList<BrandModal> featuredBrands = <BrandModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }

  /// Fetch all brands from Firestore
  Future<void> fetchBrands() async {
    try {
      isLoading.value = true;

      final brandRepo = Get.put(BrandRepository());
      final brands = await brandRepo.fetchAllBrands();

      allBrands.assignAll(brands);

      // Featured brands filter (locally bhi kar sakte ho)
      featuredBrands.assignAll(
        brands.where((b) => b.isFeatured).toList(),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}