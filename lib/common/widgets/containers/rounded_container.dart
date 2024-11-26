import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
/// A container widget with rounded corners and customizable properties.
class SRoundedContainer extends StatelessWidget {
  const SRoundedContainer({
    super.key, 
    this.child, 
    this.radius = SSizes.cardRadiusLg, 
    this.width, 
    this.height, 
    this.showShadow = true,
    this.showBorder = false, 
    this.borderColor = SColors.primary, 
    this.margin, 
    this.padding = const EdgeInsets.all(SSizes.md), 
    this.backgroundColor = SColors.white, 
    this.onTap
  });

  final Widget? child;
  final double radius;
  final double? width;
  final double? height;
  final bool showShadow;
  final bool showBorder;
  final Color borderColor;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
          boxShadow: [
            if (showShadow)
            BoxShadow(
              color: SColors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}