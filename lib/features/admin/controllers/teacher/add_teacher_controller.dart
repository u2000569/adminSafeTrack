import 'package:adminpickready/data/repositories/authentication/authentication_repository.dart';
import 'package:adminpickready/data/repositories/teacher/teacher_repository.dart';
import 'package:adminpickready/features/personalization/models/user_model.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/helpers/network_manager.dart';
import 'package:adminpickready/utils/popups/full_screen_loader.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';

class AddTeacherController extends GetxController {
  // Singleton instance
  static AddTeacherController get instance => Get.find();
  // Observables for loading state
  final isLoading = false.obs;
  // final teacherVisibility = TeacherVisibility.hidden.obs;

  // Controllers and keys
  final teacherRepository = Get.put(TeacherRepository());
  final teacherDescriptionFormKey = GlobalKey<FormState>();

  // Text Editing
  TextEditingController teacherFirstName = TextEditingController();
  TextEditingController teacherLastName = TextEditingController();
  TextEditingController teacherPhoneNumber = TextEditingController();
  TextEditingController teacherEmail = TextEditingController();
  TextEditingController teacherPassword = TextEditingController();

  RxBool teacherDataUploader = false.obs;

  // Function to add new Teacher
  Future<void> addTeacher() async{
    try {
      // show progress dialog
      showProgressDialog();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // Validate title and description form

      // Upload Teacher Thumbnail Image

      // // Map Student Data to UserModel
      // final newRecord = UserModel(
      //   email: teacherEmail.text.trim(),
      // );

      // // Call Repo to Add new teacher
      // teacherDataUploader.value = true;
      // newRecord.id = await TeacherRepository.instance;

      // Register Teacher account using email and password
      await AuthenticationRepository.instance.registerWithEmailAndPassword(teacherEmail.text, teacherPassword.text);

      // Create teacher record in firestore collection
      final teacherRepository = Get.put(TeacherRepository());
      await teacherRepository.createTeacher(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          email: teacherEmail.text,
          firstName: teacherFirstName.text,
          lastName: teacherLastName.text,
          phoneNumber: teacherPhoneNumber.text,
          role: AppRole.teacher
          )
      );

      // Create user record in firestore collection
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          email: teacherEmail.text,
          firstName: teacherFirstName.text,
          lastName: teacherLastName.text,
          phoneNumber: teacherPhoneNumber.text,
          role: AppRole.teacher
          )
      );

      SFullScreenLoader.stopLoading();
      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap, cannot create Teacher Account', message: e.toString());
    }
  }

  void showProgressDialog(){
    showDialog(
      context: Get.context!,
      barrierDismissible: false, 
      builder: (context) => PopScope(
        child: AlertDialog(
          title: const Text('Add New Teacher'),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(SImages.creatingProductIllustration, height: 200, width: 200,),
                const SizedBox(height: SSizes.spaceBtwItems,),
                // buildCheckbox('Thumbnail Image', thumbnailUploader),
                // buildCheckbox('Student Data', studentDataUploader),
                const SizedBox(height: SSizes.spaceBtwItems),
                const Text('Sit Tight, new teacher data is uploading...')
              ],
            )
          ),
        )
      )
    );
  }
}