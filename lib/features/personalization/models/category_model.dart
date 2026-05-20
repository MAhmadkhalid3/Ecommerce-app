import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String parentId;
  final bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.parentId,
    required this.isFeatured,
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        image: '',
        parentId: '',
        isFeatured: false,
      );

  /// Convert model to JSON structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  /// Map JSON oriented document snapshot from Firebase to CategoryModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      /// Map JSON Record to the Model
      return CategoryModel(
        id: document.id,
        name: data['name'] ?? '', // ✅ lowercase
        image: data['image'] ?? '', // ✅ lowercase
        parentId: data['parentId'] ?? '', // ✅ lowercase
        isFeatured: data['isFeatured'] ?? false, // ✅ lowercase
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
