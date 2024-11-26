import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/images/s_rounded_image.dart';
import 'package:adminpickready/features/media/controllers/media_controller.dart';
import 'package:adminpickready/features/media/models/image_model.dart';
import 'package:adminpickready/features/media/screens/media/widgets/folder_dropdown.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../../utils/constants/image_strings.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());

    return Obx(
      () => controller.showImagesUploaderSection.value
        ? Column(
          children: [
            SRoundedContainer(
              height: 250,
              showBorder: true,
              borderColor: SColors.borderPrimary,
              backgroundColor: SColors.primaryBackground,
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DropzoneView(
                          mime: const ['image/jpeg', 'image/png'],
                          cursor: CursorType.Default,
                          operation: DragOperation.copy,
                          onCreated: (ctrl) => controller.dropzoneController = ctrl,
                          onLoaded: () => print('Zone Loaded'),
                          onError: (ev) => print('Zone Error: $ev'),
                          onHover: () {
                            print('Zone Hovered');
                          },
                          onLeave:() {
                            print('Zone Left');
                          },
                          onDrop: (ev) async{
                            if(ev is html.File){
                              final bytes = await controller.dropzoneController.getFileData(ev);
                              final image = ImageModel(
                                url: 'url',
                                file: ev, 
                                folder: '', 
                                filename: ev.name,
                                localImageToDisplay: Uint8List.fromList(bytes),
                              );
                              controller.selectedImagesToUpload.add(image);
                            } else if (ev is String){
                              print('Zone Drop: $ev');
                            } else{
                              print('Zone Unknown type: ${ev.runtimeType}');
                            }                         
                          },
                          onDropInvalid: (ev) => print('Zone invalid MIME: $ev'),
                          onDropMultiple: (ev) async{
                            print('Zone drop multiple: $ev');
                          },
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(SImages.defaultMultiImageIcon, width: 50, height: 50,),
                            const SizedBox(height: SSizes.spaceBtwItems),
                            const Text('Drag and Drop Image Here'),
                            const SizedBox(height: SSizes.spaceBtwItems,),
                            OutlinedButton(onPressed: () => controller.selectLocalImages(), child: const Text('Select Images'))
                          ],
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwItems),

            // Show locally selected images
            if(controller.selectedImagesToUpload.isNotEmpty)
             SRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Select Folder', style: Theme.of(context).textTheme.headlineSmall,),
                          const SizedBox(width: SSizes.spaceBtwItems,),
                          MediaFolderDropdown(
                            onChanged: (MediaCategory? newValue){
                              if(newValue != null){
                                controller.selectedPath.value = newValue;
                                controller.getMediaImages();
                              }
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(onPressed: () => controller.selectedImagesToUpload.clear(), child: const Text('Remove All')),
                          const SizedBox(width: SSizes.spaceBtwItems,),
                          SDeviceUtils.isMobileScreen(context)
                            ? const SizedBox.shrink()
                            : SizedBox(
                              width: SSizes.buttonWidth,
                              child: ElevatedButton(
                                onPressed: () => controller.uploadImagesConfirmation(),
                                child: const Text('Upload'),
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections,),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: SSizes.spaceBtwItems/2,
                    runSpacing: SSizes.spaceBtwItems/2,
                    children: controller.selectedImagesToUpload
                            .where((image) => image.localImageToDisplay != null)
                            .map((element) => SRoundedImage(
                              width: 90,
                              height: 90,
                              padding: SSizes.sm,
                              imageType: ImageType.memory,
                              memoryImage: element.localImageToDisplay,
                              backgroundColor: SColors.primaryBackground,
                              ))
                            .toList(),
                  ),
                ],
              ),
             ),
             const SizedBox(height: SSizes.spaceBtwSections),
          ],
        )
        : const SizedBox.shrink(),
    );
  }
}