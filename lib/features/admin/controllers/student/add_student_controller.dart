import 'package:adminpickready/data/repositories/student/student_repository.dart';
import 'package:adminpickready/features/admin/controllers/student/student_controller.dart';
import 'package:adminpickready/features/admin/controllers/student/student_images_controller.dart';
import 'package:adminpickready/features/admin/models/grade_model.dart';
import 'package:adminpickready/features/admin/models/student_model.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/helpers/network_manager.dart';
import 'package:adminpickready/utils/logging/logger.dart';
import 'package:adminpickready/utils/popups/full_screen_loader.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../personalization/models/user_model.dart';

class AddStudentController extends GetxController {
  // Singleton instance
  static AddStudentController get instance => Get.find();

  // Observables for loading state and student details
  final isLoading = false.obs;
  final studentVisibility = StudentVisibility.hidden.obs;

  // Controllers and keys
  final studentRepository = Get.put(StudentRepository());
  final studentDescriptionFormKey = GlobalKey<FormState>();

  // Text editing controllers for input fields
  TextEditingController studentName = TextEditingController();
  TextEditingController grade = TextEditingController();
  TextEditingController studentMatric = TextEditingController();
  TextEditingController age = TextEditingController(); // need to check back between using AGE or Grade??
  TextEditingController totalStudent = TextEditingController();
  TextEditingController description= TextEditingController();
  TextEditingController gradeTextField= TextEditingController();
  TextEditingController parentTextField= TextEditingController();

  // Rx observables for selected grade and categories
  final Rx<GradeModel?> selectGrade = Rx<GradeModel?>(null);
  final Rx<UserModel?> selectParent = Rx<UserModel?>(null);

  // Flags for tracking different tasks
  RxBool thumbnailUploader = false.obs;
  RxBool studentDataUploader = false.obs;

  //Function to add new student
  Future<void> addStudent() async{
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
      if(studentName.text.isEmpty) throw 'Enter Student Name';

      // Ensure a grade is selected
      if (selectGrade.value == null) throw 'Select Grade for this Student';

      if(selectParent.value == null) throw 'Select Parent for this Student';


      // Check variation data if StudentType = variable
      
      // Upload Student Thumbnail Image
      thumbnailUploader.value = true;
      final imagesController = StudentImagesController.instance;
      // if(imagesController.selectedThumbnailImageUrl.value == null) throw 'Select Student Thumbnail Image';

      // additional Student Images
      
      // Student variation images
      
      // Map Student Data to StudentModel
      final newRecord = StudentModel(
        id: studentMatric.text.trim(), 
        // age: double.tryParse(age.text.trim()) ?? 0, 
        attendanceDate: DateTime.now(), 
        status: StudentStatus.pending, 
        // totalStudent: double.tryParse(totalStudent.text.trim()) ?? 0, 
        thumbnail: imagesController.selectedThumbnailImageUrl.value ?? '', 
        name: studentName.text.trim(),
        grade: selectGrade.value,
        parent: selectParent.value,
        totalAmount: 0
      );

      final parentId = selectParent.value!.id;
      final parentName = selectParent.value!.fullName;
      SLoggerHelper.info('Identify $parentName ID: $parentId');
      final studentDocId = newRecord.id;
      SLoggerHelper.info('Identify Student ID: $studentDocId');
      // Call Repository to Add New Student
      studentDataUploader.value = true;
      await StudentRepository.instance.addStudent(newRecord);
      await StudentRepository.instance.addChildToParent(parentId!, studentDocId);

      // Register student categories if any

      // Update Student List
      StudentController.instance.addItemToLists(newRecord);

      // Close the Progress loader
      SFullScreenLoader.stopLoading();

      // Show success Message
      showCompletionDialog();



    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap' , message: e.toString());
    }
  }

  /*---------------- Add Children to Parent Collection ----------------*/
  Future<void> addChildToParent(String parentId, String studentId) async{
    try {
      
    } catch (e) {
      
    }
  }

  void showProgressDialog(){
    showDialog(
      context: Get.context!,
      barrierDismissible: false, 
      builder: (context) => PopScope(
        child: AlertDialog(
          title: const Text('Add New Student'),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(SImages.creatingProductIllustration, height: 200, width: 200,),
                const SizedBox(height: SSizes.spaceBtwItems,),
                buildCheckbox('Thumbnail Image', thumbnailUploader),
                buildCheckbox('Student Data', studentDataUploader),
                const SizedBox(height: SSizes.spaceBtwItems),
                const Text('Sit Tight, new student data is uploading...')
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
              child: const Text('Go to Students'))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(SImages.productsIllustration, height: 200, width: 200),
            const SizedBox(height: SSizes.spaceBtwItems),
            Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall),
            const SizedBox(height: SSizes.spaceBtwItems),
            const Text('New Student Data has been Created'),
          ],
        ),
      ),
    );
  }
  
}