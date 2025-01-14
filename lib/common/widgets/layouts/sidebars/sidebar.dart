import 'package:adminpickready/common/widgets/images/s_circular_image.dart';
import 'package:adminpickready/features/personalization/controllers/settings_controller.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/image_strings.dart';
import 'menu/menu_item.dart';

class SSidebar extends StatelessWidget {
  const SSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: SColors.white,
        border: Border(right: BorderSide(width: 1, color: SColors.grey))
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(
                    () => SCircularImage(
                      width: 60,
                      height: 60,
                      padding: 0,
                      margin: SSizes.sm,
                      backgroundColor: Colors.transparent,
                      imageType: SettingsController.instance.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                      image: SettingsController.instance.settings.value.appLogo.isNotEmpty
                            ? SettingsController.instance.settings.value.appLogo
                            : SImages.darkAppLogo,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => Text(
                        SettingsController.instance.settings.value.appName,
                        style: Theme.of(context).textTheme.headlineLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SSizes.spaceBtwSections,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('MENU', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),),
                    // Menu Items
                    const SMenuItem(route: SRoutes.dashboard, icon: Iconsax.status, itemName: 'Dashboard',),
                    const SMenuItem(route: SRoutes.teacher, icon: Iconsax.activity, itemName: 'Teacher'),
                    const SMenuItem(route: SRoutes.parent, icon: Iconsax.award , itemName: 'Parent'),
                    const SMenuItem(route: SRoutes.student, icon: Iconsax.sagittarius, itemName: 'Student'),
                    const SMenuItem(route: SRoutes.grade, icon: Iconsax.pen_tool, itemName: 'Grade'),

                    Text('OTHER', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2)),
                    // Other menu items
                    const SMenuItem(route: SRoutes.profile, icon: Iconsax.user, itemName: 'Profile'),
                    // const SMenuItem(route: SRoutes.settings, icon: Iconsax.setting_2, itemName: 'Settings'),
                    const SMenuItem(route: 'logout', icon: Iconsax.logout, itemName: 'Logout'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}