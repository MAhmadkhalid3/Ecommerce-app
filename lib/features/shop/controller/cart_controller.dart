import 'package:get/get.dart';

import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/popups/loaders.dart';
import '../models/product_model.dart';

const String _kCartStorageKey = 'cart_items';

/// Single line item in the cart.
class CartItemModel {
  final String id;
  final ProductModel product;
  final int quantity;
  final ProductVariationModel? variation;
  final String? selectedSize;

  const CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    this.variation,
    this.selectedSize,
  });

  double get unitPrice {
    if (variation != null) {
      return variation!.salePrice > 0 ? variation!.salePrice : variation!.price;
    }
    return product.salePrice > 0 ? product.salePrice : product.price;
  }

  double get totalPrice => unitPrice * quantity;

  String get displayImage => variation?.image.isNotEmpty == true
      ? variation!.image
      : product.thumbnail;

  String get displayTitle => product.title;

  String get variationLabel {
    if (selectedSize != null && selectedSize!.isNotEmpty) {
      return 'Size $selectedSize';
    }
    if (variation != null && variation!.attributeValues.isNotEmpty) {
      return variation!.attributeValues.entries
          .map((e) => '${e.key} ${e.value}')
          .join(', ');
    }
    return '';
  }

  int get availableStock =>
      variation != null ? variation!.stock : product.stock;

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,
      product: product,
      quantity: quantity ?? this.quantity,
      variation: variation,
      selectedSize: selectedSize,
    );
  }

  Map<String, dynamic> toStorageJson() {
    final productJson = product.toJson();
    productJson['id'] = product.id;
    productJson.remove('createdAt');

    return {
      'id': id,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'variation': variation?.toJson(),
      'product': productJson,
    };
  }

  factory CartItemModel.fromStorageJson(Map<String, dynamic> json) {
    final productMap = Map<String, dynamic>.from(json['product'] ?? {});
    return CartItemModel(
      id: json['id'] ?? '',
      quantity: json['quantity'] ?? 1,
      selectedSize: json['selectedSize'],
      variation: json['variation'] != null
          ? ProductVariationModel.fromJson(
              Map<String, dynamic>.from(json['variation']),
            )
          : null,
      product: _productFromStorage(productMap),
    );
  }

  static ProductModel _productFromStorage(Map<String, dynamic> json) {
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

class CartController extends GetxController {
  static CartController get instance {
    if (!Get.isRegistered<CartController>()) {
      Get.put(CartController());
    }
    return Get.find();
  }

  final _localStorage = TLocalStorage();
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCartFromStorage();
  }

  /// Total quantity of all items (for badge).
  int get noOfCartItems =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  /// Subtotal before tax/shipping.
  double get totalCartPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  void _loadCartFromStorage() {
    try {
      final raw = _localStorage.readData<List<dynamic>>(_kCartStorageKey);
      if (raw == null || raw.isEmpty) return;

      final loaded = raw
          .map((e) => CartItemModel.fromStorageJson(
                Map<String, dynamic>.from(e as Map),
              ))
          .where((item) => item.id.isNotEmpty && item.product.id.isNotEmpty)
          .toList();

      cartItems.assignAll(loaded);
    } catch (_) {
      cartItems.clear();
      _localStorage.removeData(_kCartStorageKey);
    }
  }

  Future<void> _saveCartToStorage() async {
    final data = cartItems.map((item) => item.toStorageJson()).toList();
    await _localStorage.saveData(_kCartStorageKey, data);
  }

  void _persistCart() {
    cartItems.refresh();
    _saveCartToStorage();
  }

  String _cartItemId(ProductModel product, ProductVariationModel? variation) {
    return '${product.id}_${variation?.id ?? 'default'}';
  }

  CartItemModel? getCartItem(
    ProductModel product, {
    ProductVariationModel? variation,
  }) {
    final id = _cartItemId(product, variation);
    return cartItems.firstWhereOrNull((item) => item.id == id);
  }

  bool isInCart(
    ProductModel product, {
    ProductVariationModel? variation,
  }) {
    return getCartItem(product, variation: variation) != null;
  }

  /// Add product to cart. Merges quantity if the same item already exists.
  void addToCart(
    ProductModel product, {
    int quantity = 1,
    ProductVariationModel? variation,
    String? selectedSize,
  }) {
    if (quantity < 1) return;

    final stock = variation != null ? variation.stock : product.stock;
    if (stock <= 0) {
      TLoaders.warningSnackBar(
        title: 'Out of stock',
        message: '${product.title} is currently unavailable.',
      );
      return;
    }

    final id = _cartItemId(product, variation);
    final existingIndex = cartItems.indexWhere((item) => item.id == id);

    if (existingIndex >= 0) {
      final existing = cartItems[existingIndex];
      final newQty = existing.quantity + quantity;
      if (newQty > stock) {
        TLoaders.warningSnackBar(
          title: 'Stock limit',
          message: 'Only $stock item(s) available.',
        );
        return;
      }
      cartItems[existingIndex] = existing.copyWith(quantity: newQty);
    } else {
      if (quantity > stock) {
        TLoaders.warningSnackBar(
          title: 'Stock limit',
          message: 'Only $stock item(s) available.',
        );
        return;
      }
      cartItems.add(
        CartItemModel(
          id: id,
          product: product,
          quantity: quantity,
          variation: variation,
          selectedSize: selectedSize,
        ),
      );
    }

    _persistCart();
    TLoaders.successSnackBar(
      title: 'Added to cart',
      message: product.title,
    );
  }

  /// Remove one cart line entirely.
  void removeFromCart(String cartItemId) {
    cartItems.removeWhere((item) => item.id == cartItemId);
    _persistCart();
  }

  /// Remove by product + optional variation.
  void removeProductFromCart(
    ProductModel product, {
    ProductVariationModel? variation,
  }) {
    removeFromCart(_cartItemId(product, variation));
  }

  /// Set exact quantity for a line (removes line if quantity is 0).
  void updateCartItemQuantity(String cartItemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(cartItemId);
      return;
    }

    final index = cartItems.indexWhere((item) => item.id == cartItemId);
    if (index < 0) return;

    final item = cartItems[index];
    if (quantity > item.availableStock) {
      TLoaders.warningSnackBar(
        title: 'Stock limit',
        message: 'Only ${item.availableStock} item(s) available.',
      );
      return;
    }

    cartItems[index] = item.copyWith(quantity: quantity);
    _persistCart();
  }

  /// Increase quantity by 1.
  void increaseQuantity(String cartItemId) {
    final item = cartItems.firstWhereOrNull((i) => i.id == cartItemId);
    if (item == null) return;
    updateCartItemQuantity(cartItemId, item.quantity + 1);
  }

  /// Decrease quantity by 1 (removes line at 0).
  void decreaseQuantity(String cartItemId) {
    final item = cartItems.firstWhereOrNull((i) => i.id == cartItemId);
    if (item == null) return;
    updateCartItemQuantity(cartItemId, item.quantity - 1);
  }

  void clearCart() {
    cartItems.clear();
    _persistCart();
  }
}
