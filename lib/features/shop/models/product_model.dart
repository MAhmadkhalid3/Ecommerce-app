import 'package:cloud_firestore/cloud_firestore.dart';


class ProductModel {
  final String id;
  final String title;
  final String description;

  final String categoryId;

  final BrandModel brand;

  final String thumbnail;
  final List<String> images;

  final String productType;

  final double price;
  final double salePrice;

  final int stock;

  final String sku;

  final bool isFeatured;

  final Timestamp? createdAt;

  final List<ProductAttributeModel> productAttributes;

  final List<ProductVariationModel> productVariations;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.brand,
    required this.thumbnail,
    required this.images,
    required this.productType,
    required this.price,
    required this.salePrice,
    required this.stock,
    required this.sku,
    required this.isFeatured,
    required this.createdAt,
    required this.productAttributes,
    required this.productVariations,
  });

  /// Empty Product
  factory ProductModel.empty() {
    return ProductModel(
      id: '',
      title: '',
      description: '',
      categoryId: '',
      brand: BrandModel.empty(),
      thumbnail: '',
      images: [],
      productType: '',
      price: 0,
      salePrice: 0,
      stock: 0,
      sku: '',
      isFeatured: false,
      createdAt: null,
      productAttributes: [],
      productVariations: [],
    );
  }

  /// Convert Model -> JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'brand': brand.toJson(),
      'thumbnail': thumbnail,
      'images': images,
      'productType': productType,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'sku': sku,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'productAttributes':
      productAttributes.map((e) => e.toJson()).toList(),
      'productVariations':
      productVariations.map((e) => e.toJson()).toList(),
    };
  }

  /// Firestore -> Model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    if (data == null) return ProductModel.empty();

    return ProductModel(
      id: document.id,

      title: data['title'] ?? '',

      description: data['description'] ?? '',

      categoryId: data['categoryId'] ?? '',

      brand: data['brand'] != null
          ? BrandModel.fromJson(data['brand'])
          : BrandModel.empty(),

      thumbnail: data['thumbnail'] ?? '',

      images: data['images'] != null
          ? List<String>.from(data['images'])
          : [],

      productType: data['productType'] ?? '',

      price: (data['price'] ?? 0).toDouble(),

      salePrice: (data['salePrice'] ?? 0).toDouble(),

      stock: data['stock'] ?? 0,

      sku: data['sku'] ?? '',

      isFeatured: data['isFeatured'] ?? false,

      createdAt: data['createdAt'],

      productAttributes: data['productAttributes'] != null
          ? (data['productAttributes'] as List)
          .map((e) =>
          ProductAttributeModel.fromJson(e))
          .toList()
          : [],

      productVariations: data['productVariations'] != null
          ? (data['productVariations'] as List)
          .map((e) =>
          ProductVariationModel.fromJson(e))
          .toList()
          : [],
    );
  }
}

/// ================= BRAND MODEL =================

class BrandModel {
  final String id;
  final String name;
  final String image;

  const BrandModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory BrandModel.empty() {
    return const BrandModel(
      id: '',
      name: '',
      image: '',
    );
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

/// ================= PRODUCT ATTRIBUTE =================

class ProductAttributeModel {
  final String name;
  final List<String> values;

  const ProductAttributeModel({
    required this.name,
    required this.values,
  });

  factory ProductAttributeModel.fromJson(
      Map<String, dynamic> json) {
    return ProductAttributeModel(
      name: json['name'] ?? '',
      values: List<String>.from(json['values'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'values': values,
    };
  }
}

/// ================= PRODUCT VARIATION =================

class ProductVariationModel {
  final String id;

  final String image;

  final double price;

  final double salePrice;

  final int stock;

  final String sku;

  final Map<String, dynamic> attributeValues;

  const ProductVariationModel({
    required this.id,
    required this.image,
    required this.price,
    required this.salePrice,
    required this.stock,
    required this.sku,
    required this.attributeValues,
  });

  factory ProductVariationModel.fromJson(
      Map<String, dynamic> json) {
    return ProductVariationModel(
      id: json['id'] ?? '',

      image: json['image'] ?? '',

      price: (json['price'] ?? 0).toDouble(),

      salePrice:
      (json['salePrice'] ?? 0).toDouble(),

      stock: json['stock'] ?? 0,

      sku: json['sku'] ?? '',

      attributeValues:
      Map<String, dynamic>.from(
          json['attributeValues'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'sku': sku,
      'attributeValues': attributeValues,
    };
  }
}

