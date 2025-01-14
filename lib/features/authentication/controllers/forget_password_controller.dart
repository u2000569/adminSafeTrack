import 'package:adminpickready/data/repositories/authentication/authentication_repository.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/popups/full_screen_loader.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/network_manager.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // email field
  final email = TextEditingController();

  final forgetPasswordFormKey = GlobalKey<FormState>();

  // send a password reset email
  sendPasswordResetEmail() async{
    try {
      SFullScreenLoader.openLoadingDialog('Processing your request....', SImages.ridingIllustration);

    // check inteenet connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if(!isConnected){
      SFullScreenLoader.stopLoading();
      return;
    }

    // validate form
    if(!forgetPasswordFormKey.currentState!.validate()){
      SFullScreenLoader.stopLoading();
      return;
    }

    // send password reset email
    await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

    SFullScreenLoader.stopLoading();
    // Redirect
    SLoaders.successSnackBar(title: 'Email sent to $email', message: 'Check your email to reset your password');
    Get.offNamed(SRoutes.resetPassword, arguments: email.text.trim());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }
}