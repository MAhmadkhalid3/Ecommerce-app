import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/personalization/models/brand_modal.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/firebase_exception.dart';
import '../../utils/exceptions/platform_exception.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Fetch all Brands
  Future<List<BrandModal>> fetchAllBrands() async {
    try {
      final result = await _db.collection('Brand').get();

      return result.docs
          .map((doc) => BrandModal.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFirebaseAuthException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetch only Featured Brands
  Future<List<BrandModal>> fetchFeaturedBrands() async {
    try {
      final result = await _db
          .collection('Brand')
          .where('isFeatured', isEqualTo: true)
          .get();

      return result.docs
          .map((doc) => BrandModal.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFirebaseAuthException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}