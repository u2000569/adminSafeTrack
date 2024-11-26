import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_desktop.dart/students_desktop.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(desktop: StudentsDesktopScreen(),);
  }
}