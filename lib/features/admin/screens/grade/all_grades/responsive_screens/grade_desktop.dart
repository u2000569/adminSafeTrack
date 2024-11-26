import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/loaders/loading_animate.dart';
import 'package:adminpickready/features/admin/controllers/grade/grade_controller.dart';
import 'package:adminpickready/features/admin/screens/grade/all_grades/widgets/table_header.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../table/grade_data_table.dart';

class GradeDesktopScreen extends StatelessWidget {
  const GradeDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GradeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const SBreadcrumbWithHeading(heading: 'Grades', breadcrumbItems: ['Grades']),
              const SizedBox(height: SSizes.spaceBtwSections),

              // Table Body
              Obx(() {
                // Show Loader
                if(controller.isLoading.value) return const SLoadingAnimate();

                return const SRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      GradeTableHeader(),
                      SizedBox(height: SSizes.spaceBtwItems,),

                      // Table
                      GradeDataTable(),
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