import 'package:adminpickready/common/widgets/texts/page_heading.dart';
import 'package:adminpickready/features/admin/screens/dashboard/widgets/dashboard_card.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/dashboard/dashboard_controller.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SPageHeading(heading: 'Dashboard'),
              const SizedBox(height: SSizes.spaceBtwSections),

              //Card Stats
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => SDashboardCard(
                        context: context ,
                        title: 'Total Students',
                        subTitle:
                        '${controller.studentController.allItems.length}',
                        headingIcon: Iconsax.activity, 
                        headingIconColor: Colors.blue, 
                        headingIconBgColor: Colors.blue.withOpacity(0.1), 
                        stats: 25,
                        )
                    )
                  ),
                  const SizedBox(width: SSizes.spaceBtwItems,),
                  Expanded(
                    child: Obx(
                      () => SDashboardCard(
                        context: context ,
                        title: 'Total Class',
                        subTitle:
                        //  '\$${controller.studentController.allItems.fold(0.0, (previousValue, element) => previousValue).toStringAsFixed(2)}',
                        '${controller.gradeController.allItems.length}',
                        headingIcon: Iconsax.note, 
                        headingIconColor: Colors.deepOrange, 
                        headingIconBgColor: Colors.deepOrange.withOpacity(0.1), 
                        stats: 2,
                        )
                    )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}