import 'package:adminpickready/features/admin/controllers/grade/grade_controller.dart';
import 'package:adminpickready/features/admin/models/category_model.dart';
import 'package:adminpickready/features/admin/models/grade_model.dart';
import 'package:adminpickready/utils/helpers/network_manager.dart';
import 'package:adminpickready/utils/popups/full_screen_loader.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/grades/grade_repository.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';

class CreateGradeController extends GetxController {
  static CreateGradeController get instace => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Toggle Category Selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }

    update();
  }

  /// Method to reset fields
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
  }

  /// Pick Thumbnail Image from Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Register new Grade
  Future<void> createGrade() async{
    try {
      // Start Loading
      SFullScreenLoader.popUpCircular();

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      final newRecord = GradeModel(
        id: '', 
        image: imageURL.value, 
        name: name.text.trim(),
        studentsCount: 0
      );

      // Call Repository to Create New Grade
      newRecord.id = await GradeRepository.instance.creategrade(newRecord);

      // Register grade categories if any

      // Update list
      GradeController.instance.addItemToLists(newRecord);

      // Re-fetch the grades to include the newly created grade
      // await GradeController.instance.fetchItems(); // Ensure the list refreshes from Firestore

      update();

      resetFields();

      SFullScreenLoader.stopLoading();

      SLoaders.successSnackBar(title: 'Complete', message: 'New Grade has been added');
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }
}