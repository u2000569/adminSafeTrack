import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/images/s_rounded_image.dart';
import 'package:adminpickready/features/admin/controllers/student/student_images_controller.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentThumbnailImage extends StatelessWidget {
  const StudentThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentImagesController controller = Get.put(StudentImagesController());

    return SRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Student thumbnail Text
          Text('Student Thumbnail',  style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SSizes.spaceBtwItems),

          // Container for student Thumbnail
          SRoundedContainer(
            height: 300,
            backgroundColor: SColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          () => SRoundedImage(
                            image: controller.selectedThumbnailImageUrl.value ?? SImages.defaultSingleImageIcon,
                            imageType: controller.selectedThumbnailImageUrl.value == null ? ImageType.asset : ImageType.network,
                            )
                        )
                      )
                    ],
                  ),

                  // Add Thumbnnail Button
                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                      onPressed: () => controller.selectThumbnailImage(),
                      child: const Text('Add Thumbnail'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}