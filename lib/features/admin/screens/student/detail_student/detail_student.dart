import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:adminpickready/common/widgets/page_not_found/page_not_found.dart';
import 'package:adminpickready/features/admin/screens/student/detail_student/responsive_screens/student_detail_desktop.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailStudent extends StatelessWidget {
  const DetailStudent({super.key});

  @override
  Widget build(BuildContext context) {

    final student = Get.arguments;

    return student != null 
    ? SSiteTemplate(desktop: StudentDetailDesktopScreen(student: student),) 
    : const SPageNotFound();
    
  }
}