import 'package:adminpickready/features/admin/screens/teacher/add_teacher/widget/bottom_nav_widget.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../widget/teacher_detail_widget.dart';

class AddTeacherDesktopScreen extends StatelessWidget {
  const AddTeacherDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: TeacherBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // breadcrumbs
              SBreadcrumbWithHeading(
                heading: 'Teacher', 
                breadcrumbItems: [SRoutes.teacher, 'Teacher']
              ),
              SizedBox(height: SSizes.spaceBtwSections,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TeacherDetail(),
                        SizedBox(height: SSizes.spaceBtwSections),
                      ],
                    )
                  )
                ],
              )
            ],
          ),
        ) ,
      ),
    );
  }
}