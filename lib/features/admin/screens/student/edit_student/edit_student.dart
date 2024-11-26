import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:adminpickready/common/widgets/page_not_found/page_not_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/student/edit_student_controller.dart';
import 'responsive_screen/edit_student_desktop.dart';

class EditStudentScreen extends StatelessWidget {
  const EditStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditStudentController());
    final student = Get.arguments;
    controller.initStudentData(student);

    return student != null
        ? SSiteTemplate(desktop: EditStudentDesktopScreen(student:student),)
        : const SPageNotFound();
  }
}