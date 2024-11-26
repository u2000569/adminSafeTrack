import 'dart:typed_data';

import 'package:adminpickready/features/media/screens/media/widgets/media_content.dart';
import 'package:adminpickready/features/media/screens/media/widgets/media_uploader.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/popups/full_screen_loader.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import '../../../utils/popups/dialogs.dart';
import '../models/image_model.dart';

class MediaController extends GetxController{
  static MediaController get instance => Get.find();
  
  late DropzoneViewController dropzoneController;

  // Lists to store additional product images
  final RxBool loading = false.obs;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;

  final int initialLoadCount = 20;
  final int loadMoreCount = 25;

  late ListResult bannerImagesListResult;
  late ListResult productImagesListResult;
  late ListResult brandImagesListResult;
  late ListResult categoryImagesListResult;
  late ListResult userImagesListResult;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;
  // final MediaRepository mediaRepository = MediaRepository();

  // Get Images
  void getMediaImages() async{
    try{
      loading.value = true;
    } catch (e){
      loading.value = false;
      SLoaders.errorSnackBar(title: 'Oh snap', message: 'Unable to fetch Images, Something wrong');
    }
  }

  // Select Local Images on Button Press
  Future<void> selectLocalImages() async{
    final files = await dropzoneController.pickFiles(multiple: true, mime: ['image/jpeg'],);

    if(files.isNotEmpty){
      for(var file in files){
        if(file is html.File){
          final bytes = await dropzoneController.getFileData(file);
          final image = ImageModel(
            url: 'url', 
            folder: 'folder', 
            filename: file.name, 
            file: file, 
            localImageToDisplay: Uint8List.fromList(bytes),
          );
          selectedImagesToUpload.add(image);
        }
      }
    }
  }

  // / Upload Images Confirmation Popup
  void uploadImagesConfirmation(){
    if(selectedPath.value == MediaCategory.folders){
      SLoaders.warningSnackBar(title: 'Select Folder', message: 'Please Select the Folder in order to upload the images');
      return;
    }

    SDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
      content: 'Are you sure you want to upload all the Images in ${selectedPath.value.name.toUpperCase()} folder?',
      );
  }

  /// Upload Images
   Future<void> uploadImages() async{
    try{
      // Remove confirmation box
      Get.back();

      // Start Loader
      uploadImagesLoader();

      // Get the selected category
      MediaCategory selectedCategory = selectedPath.value;

      // Get the corresponding list to update
      RxList<ImageModel> targetList;

      // Check the selected category and update the corresponding list
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      // Upload and add images to the target list
      // Using a reverse loop to avoid 'Concurrent modification during iteration' error
      for(int i = selectedImagesToUpload.length - 1; i >= 0; i--){
        var selectedImage =  selectedImagesToUpload[i];
        final image = selectedImage.file!;

        // Upload Image to the storage
        // final ImageModel uploadedImage = await mediaRepository.uploadImageFileInStorage(
        //   file: image,
        //   path: getSelectedPath(),
        //   imageName: selectedImage.filename,
        // );

        // Upload Image to the Firestore
        // uploadedImage.mediaCategory = selectedCategory.name;
        // final id = await mediaRepository.uploadImageFileInDatabase(uploadedImage);

        // uploadedImage.id = id;

        // selectedImagesToUpload.removeAt(i);
        // targetList.add(uploadedImage);

      }
      SFullScreenLoader.stopLoading();
    } catch (e){
      // Stop loader in case of an error
      SFullScreenLoader.stopLoading();
      // Show a warning snack-bar for the error
      SLoaders.warningSnackBar(title: 'Error Uploading Images', message: 'Something went wrong while uploading your images.');
    }
   }

   /// Upload Images Loader
   void uploadImagesLoader(){
    showDialog(
      context: Get.context!, 
      barrierDismissible: false ,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Uploading Images'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(SImages.uploadingImageIllustration, height: 300, width: 300,),
              const SizedBox(height: SSizes.spaceBtwItems,),
              const Text('Sit Tight, YOur Images are uploading'),
            ],
          ),
        )
        ),
      );
   }

    /// Images Selection Bottom Sheet
    Future<List<ImageModel>?> selectImageFromMedia(
      {List<String>? alreadySelectedUrls, bool allowSelection = true, bool allowMultipleSelection = false}
    ) async{
      showImagesUploaderSection.value = true;
      List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
        isScrollControlled: true,
        backgroundColor: SColors.primaryBackground,
        FractionallySizedBox(
          heightFactor: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child:  Column(
                children: [
                  const MediaUploader(),
                  MediaContent(
                    allowSelection: allowSelection, 
                    allowMultipleSelection: allowMultipleSelection)
                ],
              ),
            ),
          ),
        )
      );

      return selectedImages;
    }
}