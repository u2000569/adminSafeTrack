import 'package:adminpickready/common/widgets/images/s_rounded_image.dart';
import 'package:adminpickready/common/widgets/shimmers/shimmer.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/personalization/controllers/user_controller.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../appbar/appbar.dart';

class SHeader extends StatelessWidget implements PreferredSizeWidget{
  const SHeader({
    super.key, 
    required this.scaffoldKey
  });

  /// GlobalKey to access the Scaffold state
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Container(
      /// BAckground Color, BOttom Border
      decoration: const BoxDecoration(
        color: SColors.white,
        border: Border(bottom: BorderSide(color: SColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: SSizes.md,vertical: SSizes.sm),
      child: SAppBar(
        leadingIcon: !SDeviceUtils.isDesktopScreen(context) ? Iconsax.menu : null,
        leadingOnPressed: !SDeviceUtils.isDesktopScreen(context) ? () => scaffoldKey.currentState?.openDrawer() : null,
        title: Row(
          children: [
            /// Search
            if(SDeviceUtils.isDesktopScreen(context))
            SizedBox(
              width: 400,
              child: TextFormField(
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.search_normal),
                hintText: 'Search anything...'
                ),
              ),
            )
          ],
        ),
        actions: [
          // Search Icon on mobile
          if (!SDeviceUtils.isDesktopScreen(context)) IconButton(icon: const Icon(Iconsax.search_normal), onPressed: () {}),
          // Notification Icon
          IconButton(icon: const Icon(Iconsax.notification), onPressed: () {}),
          const SizedBox(width: SSizes.spaceBtwItems / 2),

          /// User Data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // User Profile Image
              Obx(
                () => SRoundedImage(
                width: 40,
                padding: 2,
                height: 40,
                fit: BoxFit.cover,
                imageType: controller.user.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                image: controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture : SImages.user,
                ),
              ),

          const SizedBox(width: SSizes.sm),

          /// User Profile Data [Hide on Mobile]
          Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.loading.value
                  ? const SShimmer(width: 50, height: 13)
                  : Text(controller.user.value.fullName, style: Theme.of(context).textTheme.titleLarge),
                controller.loading.value
                  ? const SShimmer(width: 70, height: 13)
                  : Text(controller.user.value.email, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
            )
            ],
          )
        ],
      ) ,
    );
  }

  @override
  //TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(SDeviceUtils.getAppBarHeight() + 15);
}