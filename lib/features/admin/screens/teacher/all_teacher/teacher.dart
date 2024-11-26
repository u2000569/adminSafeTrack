import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:adminpickready/features/admin/screens/teacher/all_teacher/responsive_screen/teacher_desktop.dart';
import 'package:flutter/cupertino.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(desktop: TeacherDesktopScreen(),);
  }
}