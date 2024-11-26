import 'package:cloud_firestore/cloud_firestore.dart';

class GradeCategoryModel {
  String? id;
  final String gradeId; //make it same like a name of class
  final String categoryId;

  GradeCategoryModel({
    this.id,
    required this.gradeId,
    required this.categoryId,
  });

  Map<String, dynamic> toJson(){
    return{
      'gradeId': gradeId,
      'categoryId': categoryId,
    };
  }

  factory GradeCategoryModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;
    return GradeCategoryModel(
      id: snapshot.id,
      gradeId: data['gradeId'] as String, 
      categoryId:data['categoryId'] as String,
    );
  }
}