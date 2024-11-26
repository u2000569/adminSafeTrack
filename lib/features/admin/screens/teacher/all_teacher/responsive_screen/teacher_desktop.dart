
import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/loaders/loading_animate.dart';
import 'package:adminpickready/features/admin/controllers/teacher/teacher_controller.dart';
import 'package:adminpickready/features/admin/screens/teacher/all_teacher/table/teacher_data_table.dart';
import 'package:adminpickready/features/admin/screens/teacher/all_teacher/widgets/teacher_table_header.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherDesktopScreen extends StatelessWidget {
  const TeacherDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const SBreadcrumbWithHeading(heading: 'Teacher', breadcrumbItems: ['Teacher']),
              const SizedBox(height: SSizes.spaceBtwSections,),

              // Table Body
              Obx(() {
                  // Show Loader
                  if(controller.isLoading.value) return const SLoadingAnimate();

                  return const SRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      TeacherTableHeader(),
                      SizedBox(height: SSizes.spaceBtwItems),

                      // Table
                      TeacherTable(),
                    ],
                  ),
                );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}