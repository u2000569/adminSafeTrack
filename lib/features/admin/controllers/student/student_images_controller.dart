import 'package:adminpickready/features/admin/models/student_variation_model.dart';
import 'package:adminpickready/features/media/controllers/media_controller.dart';
import 'package:adminpickready/features/media/models/image_model.dart';
import 'package:get/get.dart';

class StudentImagesController extends GetxController {
  // Singleton instance
  static StudentImagesController get instance => Get.find();

  // Rx Observables for the selected thumbnail image
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  // Lists to store additional product images
  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  /// Function to remove Product image
  Future<void> removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
  }

  void selectThumbnailImage() async{
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    // Handle the selected images
    if(selectedImages != null && selectedImages.isNotEmpty){
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  /// Pick Thumbnail Image from Media
  void selectVariationImage(StudentVariationModel variation) async{
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    // Handle the selected images
    if(selectedImages != null && selectedImages.isNotEmpty){
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      variation.image.value = selectedImage.url;
    }
  }

  /// Pick Thumbnail Image from Gallery
  void selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages =
        await controller.selectImageFromMedia(allowMultipleSelection: true, alreadySelectedUrls: additionalProductImagesUrls);

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }
  
}