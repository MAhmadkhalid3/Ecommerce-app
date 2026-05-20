
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../features/personalization/models/category_model.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/firebase_exception.dart';
import '../../utils/exceptions/platform_exception.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  /// Variable
  final db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try{
      final snapshot = await db.collection("Categories").get();
      final list = snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      return list;
    }on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFirebaseAuthException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }catch(e){throw "Something went wrong";}}
}