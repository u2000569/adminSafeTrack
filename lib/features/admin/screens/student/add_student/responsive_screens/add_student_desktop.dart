import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/student/student_images_controller.dart';
import '../../edit_student/widgets/edit_parent_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/grade_widget.dart';
import '../widgets/student_description.dart';
import '../widgets/thumbnail_widget.dart';

class AddStudentDesktopScreen extends StatelessWidget {
  const AddStudentDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentImagesController());
    return Scaffold(
      bottomNavigationBar: const StudentBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // breadcrumbs
              const SBreadcrumbWithHeading(
                heading: 'Add Student', 
                breadcrumbItems: [SRoutes.student, 'Add Student']
              ),
              const SizedBox(height: SSizes.spaceBtwSections,),

              // Add Student
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Info
                        StudentNameAndDescription(),
                        SizedBox(height: SSizes.spaceBtwSections / 2),
                        StudentParent(),
                        SizedBox(height: SSizes.spaceBtwSections / 2),
                        // Student Grade same as ProductBrand
                        StudentGrade(),
                        SizedBox(height: SSizes.spaceBtwSections)
                      ],
                    )
                  ),
                  const SizedBox(width: SSizes.defaultSpace,),

                  // Sidebar
                  Expanded(
                    child: Column(
                      children: [
                        // Student Thumbnail
                        const StudentThumbnailImage(),
                        const SizedBox(height: SSizes.spaceBtwSections,),

                        // Student Image
                        SRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('All Student Images', style: Theme.of(context).textTheme.headlineSmall),
                              const SizedBox(height: SSizes.spaceBtwItems),
                              // StudentAdditionalImages(
                                
                              // )
                            ],
                          ),
                        ),
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