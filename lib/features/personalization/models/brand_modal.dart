import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModal {
  final String brandId;
  final String image;
  final String name;
  final bool isFeatured;
  final String productCount;

  BrandModal({
    required this.brandId,
    required this.image,
    required this.name,
    required this.isFeatured,
    required this.productCount,
  });

  // Empty Brand
  static BrandModal empty() => BrandModal(
    brandId: '',
    image: '',
    name: '',
    isFeatured: false,
    productCount: '0',
  );

  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'image': image,
      'name': name,
      'isFeatured': isFeatured,
      'productCount': productCount,
    };
  }

  factory BrandModal.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return BrandModal(
      brandId: data['brandId'] ?? '',
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      productCount: data['productCount'] ?? '0',
    );
  }
}