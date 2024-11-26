import 'package:adminpickready/common/styles/spacing_styles.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SLoginTemplate extends StatelessWidget {
  const SLoginTemplate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: SSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SSizes.cardRadiusLg),
              color: SHelperFunctions.isDarkMode(context) ? SColors.black:Colors.white
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}