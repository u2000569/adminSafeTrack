import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'reponsive_screens/create_grade_desktop.dart';

class CreateGradeScreen extends StatelessWidget {
  const CreateGradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(desktop: CreateGradeDesktopScreen());
  }
}