import 'package:flutter/material.dart';

class SResponsiveWidget extends StatelessWidget {
  const SResponsiveWidget({super.key, required this.desktop, required this.tablet, required this.mobile});

  /// Widget for desktop layout
  final Widget desktop;

  /// Widget for tablet layout
  final Widget tablet;

  /// Widget for mobile layout
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraint) {
        if(constraint.maxWidth >= 1400){
          return desktop;
        }else if (constraint.maxWidth <1400){
          return tablet;
        }else{
          return mobile;
        }
        // if (constraints.maxWidth >= TSizes.desktopScreenSize) {
        //   return desktop;
        // } else if (constraints.maxWidth < TSizes.desktopScreenSize && constraints.maxWidth >= TSizes.tabletScreenSize) {
        //   return tablet;
        // } else {
        //   return mobile;
        // }
      },
    );
  }
}