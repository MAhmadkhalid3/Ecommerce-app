import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../features/shop/models/product_model.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/firebase_exception.dart';
import '../../utils/exceptions/platform_exception.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getIsFeaturedProduct()
  async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .limit(6)
          .get();
      return snapshot.docs.map(ProductModel.fromSnapshot).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFirebaseAuthException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<void> upsertProducts(List<ProductModel> products) async {
    try {
      final batch = _db.batch();
      for (final product in products) {
        final ref = _db.collection('Products').doc(product.id);
        batch.set(ref, product.toJson(), SetOptions(merge: true));
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFirebaseAuthException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw "Something went wrong. Please try again";
    }
  }

  /// Get Products based on the Brand
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      print('Total docs: ${querySnapshot.docs.length}'); // ✅ kitne products mile



      final List<ProductModel> products =
      querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();

      return products;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<void> uploadProducts() async {
  try {
  for (int i = 1; i <= 20; i++) {
  /// 001, 002, 003...
  final productId = i.toString().padLeft(3, '0');

  final product = {
  "id": productId,

  "title": "Nike Air Max $productId",

  "description": "Comfortable running shoes",

  "categoryId": "shoes",

  "brandId": "nike",

  "brand": {
  "id": "nike",
  "name": "Nike",
  "image":
  "https://your-brand-image-url.com/nike.png",
  },

  "thumbnail":
  "https://your-thumbnail-url.com/product$productId.png",

  "images": [
  "https://your-image-url.com/${productId}_1.png",
  "https://your-image-url.com/${productId}_2.png",
  "https://your-image-url.com/${productId}_3.png",
  ],

  "productType": "variable",

  "price": 120,

  "salePrice": 100,

  "stock": 50,

  "sku": "NIKE-$productId",

  "isFeatured": i % 2 == 0,

  "createdAt": Timestamp.now(),

  "productAttributes": [
  {
  "name": "Color",
  "values": ["Red", "Blue", "Black"]
  },
  {
  "name": "Size",
  "values": ["40", "41", "42"]
  }
  ],

  "productVariations": [
  {
  "id": "1",

  "image":
  "https://your-image-url.com/red$productId.png",

  "price": 100,

  "salePrice": 90,

  "stock": 5,

  "sku": "NIKE-RED-40-$productId",

  "attributeValues": {
  "Color": "Red",
  "Size": "40"
  }
  },

  {
  "id": "2",

  "image":
  "https://your-image-url.com/blue$productId.png",

  "price": 110,

  "salePrice": 95,

  "stock": 10,

  "sku": "NIKE-BLUE-41-$productId",

  "attributeValues": {
  "Color": "Blue",
  "Size": "41"
  }
  }
  ]
  };

  await _db
      .collection('Products')
      .doc(productId)
      .set(product);

  print("✅ Product $productId uploaded");
  }

  print("🎉 All 20 products uploaded successfully");
  } catch (e) {
  print("❌ Error: $e");
  }
  }

  Future<void> printAllProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Products')
          .get();

      for (final doc in snapshot.docs) {
        print('🔥 Product ID: ${doc.id}');
        print('📦 Data: ${doc.data()}');
        print('---');
      }
      print('✅ Total products: ${snapshot.docs.length}');
    } catch (e) {
      print('❌ Error: $e');
    }
  }
  }


