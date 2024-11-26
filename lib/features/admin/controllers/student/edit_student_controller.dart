import 'package:adminpickready/data/repositories/student/student_repository.dart';
import 'package:adminpickready/features/admin/controllers/student/student_images_controller.dart';
import 'package:adminpickready/features/admin/models/grade_model.dart';
import 'package:adminpickready/features/admin/models/student_model.dart';
import 'package:adminpickready/features/personalization/models/user_model.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class EditStudentController extends GetxController {
  static EditStudentController get instance => Get.find();

  final isLoading = false.obs;
  final imagesController = Get.put(StudentImagesController());
  final  studentRepository = Get.put(StudentRepository());

  final studentDescriptionFormKey = GlobalKey<FormState>();

  //Text editing controllers for input fields
  TextEditingController studentName = TextEditingController();
  TextEditingController studentID = TextEditingController();
  TextEditingController studentParent = TextEditingController();

  TextEditingController gradeTextField = TextEditingController();
  TextEditingController parentTextField = TextEditingController();

  // Rx observables for selected grade
  final Rx<GradeModel?> selectedGrade = Rx<GradeModel?>(null);
  final Rx<UserModel?> selectedParent = Rx<UserModel?>(null);

  // Flags for tracking different tasks
  RxBool thumbnailUploader = true.obs;
  RxBool studentDataUploader = false.obs;

  // Initialized Student Data
  void initStudentData(StudentModel student){
    try {
      isLoading.value = true;

      // basic info
      studentName.text = student.name;
      studentID.text = student.id;
      selectedParent.value = student.parent;
      // Student Grade
      selectedGrade.value = student.grade;
      gradeTextField.text = student.grade?.name ?? '';

      // Student Thumbnail
      imagesController.selectedThumbnailImageUrl.value = student.thumbnail;

      isLoading.value = false;
      update();
    } catch (e) {
      if(kDebugMode) print(e);
    }
  }

  // Function to edit student data
  Future<void> editStudent(StudentModel student) async{
    try {
      showProgressDialog();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // Validate student and description form
      if (!studentDescriptionFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // Ensure a grade is selected
      if(selectedGrade.value == null) throw 'Select Grade for the Student';

      // Upload Product Thumbnail Image
      // final imagesController = StudentImagesController.instance;
      // if (imagesController.selectedThumbnailImageUrl.value == null || imagesController.selectedThumbnailImageUrl.value!.isEmpty) {
      //   throw 'Upload Product Thumbnail Image';
      // }

      // Update Student Data
      student.name = studentName.text;
      student.id = studentID.text;
      student.thumbnail = imagesController.selectedThumbnailImageUrl.value ?? '';
      student.parent = selectedParent.value;
      student.grade = selectedGrade.value;

      // Call repository to update student data
      studentDataUploader.value = true;
      await StudentRepository.instance.updateStudent(student);

      SFullScreenLoader.stopLoading();

      showCompletionDialog();

    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh snap, Fail to update student data', message: e.toString());
    }
  }

  void showProgressDialog(){
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Updating Student Data'),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(SImages.creatingProductIllustration, height: 200, width: 200),
                const SizedBox(height: SSizes.spaceBtwItems),
                buildCheckbox('Thumbnail Image', thumbnailUploader),
                const SizedBox(height: SSizes.spaceBtwItems),
                const Text('Sit Tight, Student Data is uploading...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build a checkbox widget
  Widget buildCheckbox(String label, RxBool value) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.blue)
              : const Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        const SizedBox(width: SSizes.spaceBtwItems),
        Text(label),
      ],
    );
  }

  // Show completion dialog
  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('Go to Students'))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(SImages.productsIllustration, height: 200, width: 200),
            const SizedBox(height: SSizes.spaceBtwItems),
            Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall),
            const SizedBox(height: SSizes.spaceBtwItems),
            Text('${studentName.text} has been Edited'),
          ],
        ),
      ),
    );
  }


}