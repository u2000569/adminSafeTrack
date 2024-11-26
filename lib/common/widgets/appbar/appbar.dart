import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:adminpickready/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Custom appbar for achieving a desired design goal.
  /// - Set [title] for a custom title.
  /// - [showBackArrow] to toggle the visibility of the back arrow.
  /// - [leadingIcon] for a custom leading icon.
  /// - [leadingOnPressed] callback for the leading icon press event.
  /// - [actions] for adding a list of action widgets.
  /// - Horizontal padding of the appbar can be customized inside this widget.
  const SAppBar({
    super.key, 
    this.title, 
    this.showBackArrow = false, 
    this.leadingIcon, 
    this.actions, 
    this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
        ? IconButton(onPressed: () => Get.back() , icon: Icon(Iconsax.arrow_left, color: dark ? SColors.white : SColors.black,))
        : leadingIcon != null
        ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
        : null,
        title: title,
        actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SDeviceUtils.getAppBarHeight());
}