import 'package:get/get.dart';

import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/popups/loaders.dart';
import '../models/product_model.dart';

const String _kWishlistStorageKey = 'wishlist_products';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final _localStorage = TLocalStorage();
  final RxList<ProductModel> wishlistProducts = <ProductModel>[].obs;

  int get wishlistCount => wishlistProducts.length;

  @override
  void onInit() {
    super.onInit();
    _loadWishlistFromStorage();
  }

  void _loadWishlistFromStorage() {
    try {
      final raw = _localStorage.readData<List<dynamic>>(_kWishlistStorageKey);
      if (raw == null || raw.isEmpty) return;

      final loaded = raw
          .map((e) => _productFromStorage(Map<String, dynamic>.from(e as Map)))
          .where((p) => p.id.isNotEmpty)
          .toList();

      wishlistProducts.assignAll(loaded);
    } catch (_) {
      wishlistProducts.clear();
      _localStorage.removeData(_kWishlistStorageKey);
    }
  }

  Future<void> _saveWishlistToStorage() async {
    final data = wishlistProducts.map(_productToStorage).toList();
    await _localStorage.saveData(_kWishlistStorageKey, data);
  }

  void _persist() {
    wishlistProducts.refresh();
    _saveWishlistToStorage();
  }

  bool isInWishlist(String productId) {
    return wishlistProducts.any((p) => p.id == productId);
  }

  void toggleWishlist(ProductModel product) {
    if (isInWishlist(product.id)) {
      removeFromWishlist(product.id);
    } else {
      addToWishlist(product);
    }
  }

  void addToWishlist(ProductModel product) {
    if (product.id.isEmpty || isInWishlist(product.id)) return;

    wishlistProducts.add(product);
    _persist();

    TLoaders.successSnackBar(
      title: 'Added to wishlist',
      message: product.title,
    );
  }

  void removeFromWishlist(String productId) {
    wishlistProducts.removeWhere((p) => p.id == productId);
    _persist();
  }

  void clearWishlist() {
    wishlistProducts.clear();
    _persist();
  }

  Map<String, dynamic> _productToStorage(ProductModel product) {
    final json = product.toJson();
    json['id'] = product.id;
    json.remove('createdAt');
    return json;
  }

  ProductModel _productFromStorage(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      brand: json['brand'] != null
          ? BrandModel.fromJson(Map<String, dynamic>.from(json['brand']))
          : BrandModel.empty(),
      thumbnail: json['thumbnail'] ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      productType: json['productType'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      salePrice: (json['salePrice'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      sku: json['sku'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      createdAt: null,
      productAttributes: json['productAttributes'] != null
          ? (json['productAttributes'] as List)
              .map((e) => ProductAttributeModel.fromJson(
                    Map<String, dynamic>.from(e),
                  ))
              .toList()
          : [],
      productVariations: json['productVariations'] != null
          ? (json['productVariations'] as List)
              .map((e) => ProductVariationModel.fromJson(
                    Map<String, dynamic>.from(e),
                  ))
              .toList()
          : [],
    );
  }
}
