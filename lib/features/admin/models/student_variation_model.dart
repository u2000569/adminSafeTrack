import 'package:get/get_rx/src/rx_types/rx_types.dart';

class StudentVariationModel {
  final String id;
  Rx<String> image;
  Map<String, String> attributeValues;

  StudentVariationModel({
    required this.id,
    String image = '',
    required this.attributeValues
  }) : image = image.obs;
  
   /// Create Empty func for clean code
   static StudentVariationModel empty() => StudentVariationModel(id: '', attributeValues: {});

   /// Json Format
   toJson(){
    return {
      'Id': id,
      'Image': image.value,
      'AttributeValues' : attributeValues
    };
   }

   /// Map Json oriented document snapshot from Firebase to Model
   factory StudentVariationModel.fromJson(Map<String, dynamic> document){
    final data = document;
    if(data.isEmpty) return StudentVariationModel.empty();
    return StudentVariationModel(
      id: data['Id'] ?? '', 
      image: data['Image'] ?? '',
      attributeValues: Map<String, String>.from(data['AttibuteValues'])
      );
   }
}