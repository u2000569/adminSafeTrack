import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(id: 'id', name: '', image: '');

  /// Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      // 'IsFeatured': isFeatured,
      // 'CreatedAt': createdAt,
      // 'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data() != null){
      final data = document.data()!;

      // Map JSON Record to the model
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        // isFeatured: data['IsFeatured'] ?? false,
        // createdAt: data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        // updatedAt: data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}