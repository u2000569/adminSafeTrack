import 'package:adminpickready/data/repositories/authentication/authentication_repository.dart';
import 'package:adminpickready/data/repositories/user/user_repository.dart';
import 'package:adminpickready/features/personalization/models/user_model.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/parent/parent_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

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

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
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
      SFullScreenLoader.stopLoading();
      // Redirect 
      AuthenticationRepository.instance.screenRedirect();
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
                // buildCheckbox('Thumbnail Image', thumbnailUploader),
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
}