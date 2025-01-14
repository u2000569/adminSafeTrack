import 'package:adminpickready/data/repositories/authentication/authentication_repository.dart';
import 'package:adminpickready/data/repositories/user/user_repository.dart';
import 'package:adminpickready/features/personalization/models/user_model.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/logging/logger.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/parent/parent_repository.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../authentication/controllers/login_contoller.dart';

class AddParentController extends GetxController {
  static AddParentController get instance => Get.find();

  final isLoading = false.obs;

  final parentRepository = Get.put(ParentRepository());
  final parentDescriptionFormKey = GlobalKey<FormState>();

  TextEditingController parentFirstName = TextEditingController();
  TextEditingController parentLastName = TextEditingController();
  TextEditingController parentPhoneNumber = TextEditingController();
  TextEditingController parentEmail = TextEditingController();
  TextEditingController parentPassword = TextEditingController();

  RxBool parentDataUploader = false.obs;

  Future<void> addParent() async{
    try{
      showProgressDialog();
      final loginController = LoginController.instance;
      final adminEmail = loginController.localStorage.read('REMEMBER_ME_EMAIL');
      final adminPassword = loginController.localStorage.read('REMEMBER_ME_PASSWORD');
      SLoggerHelper.info('Admin Credentials: $adminEmail, $adminPassword');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // validation form
      if(!parentDescriptionFormKey.currentState!.validate()){
        SLoggerHelper.warning('Validation Error , ${parentDescriptionFormKey.currentState}');
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.registerWithEmailAndPassword(parentEmail.text, parentPassword.text);

      final teacherRepository = Get.put(ParentRepository());
      await teacherRepository.createParent(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          email: parentEmail.text.trim(),
          firstName: parentFirstName.text.trim(),
          lastName: parentLastName.text.trim(),
          phoneNumber: parentPhoneNumber.text.trim(),
          role: AppRole.parent
        )
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          email: parentEmail.text.trim(),
          firstName: parentFirstName.text.trim(),
          lastName: parentLastName.text.trim(),
          phoneNumber: parentPhoneNumber.text.trim(),
          role: AppRole.parent
          )
      );

      await AuthenticationRepository.instance.sendPasswordResetEmail(parentEmail.text.trim());
      SLoggerHelper.info('Send Password Reset Email to $parentEmail');

      //logout the new user
      await AuthenticationRepository.instance.logoutAdmin();

      await AuthenticationRepository.instance.loginWithEmailAndPassword(adminEmail, adminPassword);
      SFullScreenLoader.stopLoading();

      showCompletionDialog();
      // SLoggerHelper.info('User created with UID: ${userRepository.createUser(UserModel(email: email))}');
      // Redirect 
      // Get.offAllNamed(SRoutes.dashboard);
    } catch (e){
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh snap, Fail to create parent account', message: e.toString());
    }
  }

  void showProgressDialog(){
    showDialog(
      context: Get.context!,
      barrierDismissible: false, 
      builder: (context) => PopScope(
        child: AlertDialog(
          title: const Text('Add New Parent'),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(SImages.creatingProductIllustration, height: 200, width: 200,),
                const SizedBox(height: SSizes.spaceBtwItems,),
                buildCheckbox('Teacher Data', parentDataUploader),
                // buildCheckbox('Student Data', studentDataUploader),
                const SizedBox(height: SSizes.spaceBtwItems),
                const Text('Wait, new parent data is uploading...')
              ],
            )
          ),
        )
      )
    );
  }

  // Build a checkbox widget
  Widget buildCheckbox(String label, RxBool value){
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
          ? const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.blue)
          : const Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        const SizedBox(width: SSizes.spaceBtwItems,),
        Text(label),
      ],
    );
  }

  void showCompletionDialog(){
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('Go to Parent'))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(SImages.productsIllustration, height: 200, width: 200),
            const SizedBox(height: SSizes.spaceBtwItems),
            Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall),
            const SizedBox(height: SSizes.spaceBtwItems),
            const Text('New Parent Data has been Created'),
          ],
        ),
      ),
    );
  }
}