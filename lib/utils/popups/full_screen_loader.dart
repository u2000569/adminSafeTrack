import 'package:adminpickready/common/widgets/loaders/circular_loader.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';

/// A utility class for managing a full-screen loading dialog.
class SFullScreenLoader{
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  ///
  /// Parameters:
  ///   - text: The text to be displayed in the loading dialog.
  ///   - animation: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation){
    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        child: Container(
          color: SHelperFunctions.isDarkMode(Get.context!) ? SColors.dark : SColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250), // Adjust the spacing as needed
               SAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        )
      )
    );
  }

  static void popUpCircular(){
    Get.defaultDialog(
      title: '',
      onWillPop: () async => false,
      content: const SCircularLoader(),
      backgroundColor: Colors.transparent,
    );
  }

  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // Close the dialog using the Navigator
  }
}