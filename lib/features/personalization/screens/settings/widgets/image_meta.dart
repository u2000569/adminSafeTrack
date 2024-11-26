import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/personalization/controllers/settings_controller.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/images/image_uploader.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return SRoundedContainer(
      padding: const EdgeInsets.symmetric(vertical: SSizes.lg, horizontal: SSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // User Image
              Obx(
                () => SImageUploader(
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  loading: controller.loading.value,
                  onIconButtonPressed: () => controller.updateAppLogo(),
                  imageType: controller.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                  image: controller.settings.value.appLogo.isNotEmpty ? controller.settings.value.appLogo : SImages.defaultImage,
                )
              ),
              const SizedBox(height: SSizes.spaceBtwItems,),
              Obx(() => Text(controller.settings.value.appName, style: Theme.of(context).textTheme.headlineLarge,)),
              const SizedBox(height: SSizes.spaceBtwSections,),
            ],
          )
        ],
      ),
    );
  }
}