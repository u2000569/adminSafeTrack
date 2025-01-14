import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/admin/controllers/student/student_images_controller.dart';
import 'package:adminpickready/features/admin/models/student_model.dart';
import 'package:adminpickready/features/admin/screens/student/add_student/widgets/thumbnail_widget.dart';
import 'package:adminpickready/features/admin/screens/student/edit_student/widgets/edit_student_description.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/device/device_utility.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/edit_grade_widget.dart';
import '../widgets/edit_parent_widget.dart';
import '../widgets/edit_student_bottomNav_widget.dart';

class EditStudentDesktopScreen extends StatelessWidget {
  const EditStudentDesktopScreen({
    super.key,
     required this.student
  });

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentImagesController());
    return Scaffold(
      bottomNavigationBar: EditStudentBottomNavButtons(student: student),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BreadCrumb
              const SBreadcrumbWithHeading(
                heading: 'Edit Student',
                returnToPreviousScreen: true, 
                breadcrumbItems: [SRoutes.student, 'Edit Student'],
                ),
              const SizedBox(height: SSizes.spaceBtwSections),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: SDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Information
                        EditStudentDescription(),
                        SizedBox(height: SSizes.spaceBtwSections),
                        // Student Grade
                        EditStudentGrade(),
                        SizedBox(height: SSizes.spaceBtwSections),
                        EditStudentParent(),
                        
                        
                      ],
                    ),
                  ),
                  const SizedBox(width: SSizes.defaultSpace),

                  //Sidebar
                  Expanded(
                    child: Column(
                      children: [
                        const StudentThumbnailImage(),
                        const SizedBox(height: SSizes.spaceBtwSections),

                        // Student Image
                        SRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Student Image', style: Theme.of(context).textTheme.headlineSmall),
                              const SizedBox(height: SSizes.spaceBtwItems),
                              
                            ],
                          ),
                        ),
                        const SizedBox(height: SSizes.spaceBtwSections),

                        
                      ],
                    ),
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