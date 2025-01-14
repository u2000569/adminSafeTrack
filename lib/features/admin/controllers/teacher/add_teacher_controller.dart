import 'package:adminpickready/data/repositories/authentication/authentication_repository.dart';
import 'package:adminpickready/data/repositories/teacher/teacher_repository.dart';
import 'package:adminpickready/features/personalization/models/user_model.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/helpers/network_manager.dart';
import 'package:adminpickready/utils/popups/full_screen_loader.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/logging/logger.dart';
import '../../../authentication/controllers/login_contoller.dart';

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

      // Validate title and description form
      if(!teacherDescriptionFormKey.currentState!.validate()){
        SLoggerHelper.warning('Validation Error , ${teacherDescriptionFormKey.currentState}');
        // teacherDescriptionFormKey.currentState?.reset();
        SFullScreenLoader.stopLoading();
        return;
      }
      

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

      await AuthenticationRepository.instance.sendPasswordResetEmail(teacherEmail.text.trim());
      SLoggerHelper.info('Send Password Reset Email to $teacherEmail');

      await AuthenticationRepository.instance.logoutAdmin();

      await AuthenticationRepository.instance.loginWithEmailAndPassword(adminEmail, adminPassword);

      SFullScreenLoader.stopLoading();
      showCompletionDialog();
      // Redirect
      // Get.offAllNamed(SRoutes.dashboard);
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
                buildCheckbox('Teacher Data', teacherDataUploader),
                const SizedBox(height: SSizes.spaceBtwItems),
                const Text('Sit Tight, new teacher data is uploading...')
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
              child: const Text('Go to Teachers'))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(SImages.productsIllustration, height: 200, width: 200),
            const SizedBox(height: SSizes.spaceBtwItems),
            Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall),
            const SizedBox(height: SSizes.spaceBtwItems),
            const Text('New Teacher Data has been Created'),
          ],
        ),
      ),
    );
  }


}