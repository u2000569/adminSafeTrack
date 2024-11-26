import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_teacher/add_teacher_desktop.dart';

class AddTeacher extends StatelessWidget {
  const AddTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(desktop: AddTeacherDesktopScreen() ,);
  }
}