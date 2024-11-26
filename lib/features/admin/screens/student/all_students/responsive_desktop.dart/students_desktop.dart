import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/loaders/loading_animate.dart';
import 'package:adminpickready/features/admin/controllers/student/student_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../table/students_table.dart';
import '../widgets/student_table_header.dart';

class StudentsDesktopScreen extends StatelessWidget {
  const StudentsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const SBreadcrumbWithHeading(
                heading: 'Students', 
                breadcrumbItems: ['Students']),
              const SizedBox(height: SSizes.spaceBtwSections,),

              //Table Body
              Obx((){
                // Show Loader
                if(controller.isLoading.value) return const SLoadingAnimate();

                return const SRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      StudentTableHeader(),
                      SizedBox(height: SSizes.spaceBtwItems,),

                      // Table
                      StudentsTable(),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}