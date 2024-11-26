import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/add_student_desktop.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(desktop:  AddStudentDesktopScreen(),);
  }
}