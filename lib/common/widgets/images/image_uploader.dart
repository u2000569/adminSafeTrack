import 'dart:typed_data';

import 'package:adminpickready/common/widgets/icons/s_circular_icon.dart';
import 'package:adminpickready/common/widgets/images/s_circular_image.dart';
import 'package:adminpickready/common/widgets/images/s_rounded_image.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/enums.dart';
import '../containers/circular_container.dart';

class SImageUploader extends StatelessWidget {
  const SImageUploader({
    super.key, 
    this.loading = false, 
    this.circular = false, 
    this.image, 
    required this.imageType, 
    this.width = 100, 
    this.height = 100, 
    this.memoryImage, 
    this.icon = Iconsax.edit_2, 
    this.top, 
    this.bottom = 0, 
    this.right, 
    this.left = 0, 
    this.onIconButtonPressed,
  });

  /// Whether to display the loading instead of icon
  final bool loading;

  /// Whether to display the image in a circular shape
  final bool circular;

  /// URL or path of the image to display
  final String? image;

  /// Type of image (network, asset, memory, etc.)
  final ImageType imageType;

  /// Width of the image uploader widget
  final double width;

  /// Height of the image uploader widget
  final double height;

  /// Byte data of the image (for memory images)
  final Uint8List? memoryImage;

  /// Icon to display on the image uploader widget
  final IconData icon;

  /// Offset from the top edge of the widget
  final double? top;

  /// Offset from the bottom edge of the widget
  final double? bottom;

  /// Offset from the right edge of the widget
  final double? right;

  /// Offset from the left edge of the widget
  final double? left;

  /// Callback function for when the icon button is pressed
  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Display the image in either circular or rounded shape
        !circular
          ? SRoundedImage(
            image: image,
            width: width,
            height: height,
            imageType: imageType,
            memoryImage: memoryImage,
            backgroundColor: SColors.primaryBackground,
            )
          : SCircularImage(
            image: image,
            width: width,
            height: height,
            imageType: imageType,
            memoryImage: memoryImage,
            backgroundColor: SColors.primaryBackground,
          ),
          // Display the edit icon button on top of the image
          Positioned(
            top: top,
            left: left,
            right: right,
            bottom: bottom,
            child: loading
              ? const SCircularContainer(
                width: SSizes.xl,
                height: SSizes.xl,
                child: CircularProgressIndicator(strokeWidth: 2, backgroundColor: SColors.primary, color: Colors.white,),
              )
              : SCircularIcon(
                icon: icon,
                size: SSizes.md,
                color: Colors.white,
                onPressed: onIconButtonPressed,
                backgroundColor: SColors.primary.withOpacity(0.9),
                )
          )
      ],
    );
  }
}