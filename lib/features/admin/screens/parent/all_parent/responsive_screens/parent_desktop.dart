import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/loaders/loading_animate.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/parent/parent_controller.dart';
import '../table/parent_data_table.dart';
import '../widgets/parent_table_header.dart';

class ParentDesktopScreen extends StatelessWidget {
  const ParentDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParentController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const SBreadcrumbWithHeading(heading: 'Parent', breadcrumbItems: ['Parent']),
              const SizedBox(height: SSizes.spaceBtwSections,),

              // Table Body
              Obx(() {
                  // Show Loader
                  if(controller.isLoading.value) return const SLoadingAnimate();

                  return const SRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      ParentTableHeader(),
                      SizedBox(height: SSizes.spaceBtwItems),

                      // Table
                      ParentTable(),
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