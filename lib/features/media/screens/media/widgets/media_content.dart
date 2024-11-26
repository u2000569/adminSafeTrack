import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/media/controllers/media_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../models/image_model.dart';

class MediaContent extends StatelessWidget {
  MediaContent({
    super.key, 
    this.allowSelection = false, 
    this.allowMultipleSelection = false, 
    this.alreadySelectedUrls, 
    this.onImagesSelected
  });

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
    final controller = Get.put(MediaController());    
    return SRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Media Images Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Media Folders', style: Theme.of(context).textTheme.headlineSmall,),
                  const SizedBox(width: SSizes.spaceBtwItems,),

                  // Media Dropdown
                  _buildMediaDropDown(controller),
                ],
              ),

              //ad Selected Images Button
              if(allowSelection) buildAddSelectedImagesButton(),
            ],
          ),
          const SizedBox(height: SSizes.spaceBtwSections,),

          // Show Media
          Obx(
            (){
              // Get Selected Folder Images
              List<ImageModel> images = _getSelectedFolderImages(controller);

              // Load Selected Images from the Already Selected Images only once otherwise
              // on Obx() rebuild UI first images will be selected then will auto un check.
              if(!loadedPreviousSelection){
                if(alreadySelectedUrls != null && alreadySelectedUrls!.isNotEmpty){
                  // Convert alreadySelectedUrls to a Set for faster lookup
                  final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);

                  for (var image in images) {
                    image.isSelected.value = selectedUrlsSet.contains(image.url);
                    if (image.isSelected.value) {
                      selectedImages.add(image);
                    }
                  }
                } else{
                  // If alreadySelectedUrls is null or empty, set all images to not selected
                  for (var image in images) {
                    image.isSelected.value = false;
                  }
                }
                loadedPreviousSelection = true;
              }

              // Loader
              if (controller.loading.value && images.isEmpty) return loaderToFetchImages();

              // Empty Widget
              if (images.isEmpty) return _buildEmptyAnimationWidget(context);

              return Column(

              );
            }
          )
        ],
      ),
    );
  }

  Padding loaderToFetchImages() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: SSizes.defaultSpace * 2),
      child: Column(
        children: [
          // SLoaderAnimation(height: 200, width: 200),
          SizedBox(height: SSizes.spaceBtwSections),
          Text('Loading Images....'),
        ],
      ),
    );
  }

  Padding _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SSizes.lg * 3),
      // child: SAnimationLoaderWidget(
      //   width: 300,
      //   height: 300,
      //   text: 'Select your Desired Folder',
      //   animation: SImages.mediaIllustration,
      //   style: Theme.of(context).textTheme.titleLarge,
      // ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller){
    List<ImageModel> images = <ImageModel>[];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages.where((image) => image.url.isNotEmpty).toList();
    }
    return images;
  }

  Widget buildAddSelectedImagesButton(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close Button
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(onPressed: () => Get.back(), icon: const Icon(Iconsax.close_circle), label: const Text('Close')),
        ),
        const SizedBox(width: SSizes.spaceBtwItems,),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(onPressed: (){
            // if (alreadySelectedUrls != null) alreadySelectedUrls!.clear();
              //
              // // Create a copy of the selected images to send back
              // List<ImageModel> selectedImagesCopy = List.from(selectedImages);
              //
              // for (var image in selectedImages) {
              //   image.isSelected.value = false;
              // }
              //
              // // Before calling Get.back, clear the selectedImages
              // selectedImages.clear();

              // Now call Get.back with the result
              Get.back(result: selectedImages);
          }, 
          icon: const Icon(Iconsax.image), 
          label: const Text('Add'),
          ),
        )
      ],
    );
  }

  Obx _buildMediaDropDown(MediaController controller){
    return Obx(
      () => SizedBox(
        width: 140,
        child: DropdownButtonFormField<MediaCategory>(
          isExpanded: false,
          value: controller.selectedPath.value,
          onChanged: (MediaCategory? newValue){
            if(newValue != null){
              for(var image in selectedImages){
                image.isSelected.value = false;
              }
              selectedImages.clear();

              controller.selectedPath.value = newValue;
              controller.getMediaImages();
            }
          },
          items: MediaCategory.values.map(
            (category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name.capitalize.toString()),
                );
              },
            ).toList(),
        ),
      )
    );
  }

  // Widget _buildSimpleList(ImageModel image){
  //   return SRoundedImage;
  // }
}