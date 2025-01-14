import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/icons/s_circular_icon.dart';
import 'package:adminpickready/common/widgets/texts/page_heading.dart';
import 'package:adminpickready/features/admin/screens/dashboard/widgets/dashboard_card.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';
import '../widgets/student_status_graph.dart';
import '../widgets/weekly_attendance.dart';

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
                        // stats: controller.studentController.allItems.length,
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
                        // stats: 2,
                        )
                    )
                  ),
                ],
              ),
              const SizedBox(height: SSizes.spaceBtwSections),
              // Graph
               Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Weekly Attendance
                        SWeeklyAttendanceGraph(),
                        SizedBox(height: SSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                  const SizedBox(width: SSizes.spaceBtwSections),
                  Expanded(
                    child: SRoundedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                               SCircularIcon(
                                icon: Iconsax.status,
                                backgroundColor: Colors.amber.withOpacity(0.1),
                                color: Colors.amber,
                                size: SSizes.md,
                              ),
                              const SizedBox(width: SSizes.spaceBtwItems),
                              Text('Student Status', style: Theme.of(context).textTheme.headlineSmall,)
                            ],
                          ),
                          const SizedBox(height: SSizes.spaceBtwSections),
                          const StudentStatusPieChart()
                        ],
                      ),
                    ),
                  )
                ],
              )
              // ATtendance Chart
              // Obx(() {
              //     // final chartData = controller.getChartData();
              //     if (chartData.isEmpty) {
              //       return const Center(child: Text('No attendance data available.'));
              //     }

              //     List<PieChartSectionData> sections = chartData.map((data) {
              //       return PieChartSectionData(
              //         title: '${data['count']}',
              //         value: data['count'].toDouble(),
              //         color: _getColorForStatus(data['status']),
              //         radius: 50,
              //       );
              //     }).toList();

              //     return PieChart(
              //       PieChartData(
              //         sections: sections,
              //         centerSpaceRadius: 40,
              //         sectionsSpace: 2,
              //       ),
              //     );
              //   }),
            ],
          ),
        ),
      ),
    );
  }
  Color _getColorForStatus(String status) {
    switch (status) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}