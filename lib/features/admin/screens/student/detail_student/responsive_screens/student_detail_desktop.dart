import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/features/admin/models/student_model.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/student_info.dart';

class StudentDetailDesktopScreen extends StatelessWidget {
  const StudentDetailDesktopScreen({
    super.key, 
    required this.student
  });

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcumbs
              SBreadcrumbWithHeading(returnToPreviousScreen: true ,heading: student.id, breadcrumbItems: const [SRoutes.student, 'Detail']),
              const SizedBox(height: SSizes.spaceBtwItems),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side Student Information
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // student info
                        StudentInfo(student: student),
                        const SizedBox(height: SSizes.spaceBtwSections),
                      ],
                    )
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}