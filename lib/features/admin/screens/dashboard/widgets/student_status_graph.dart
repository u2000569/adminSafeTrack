import 'package:adminpickready/common/widgets/containers/circular_container.dart';
import 'package:adminpickready/common/widgets/loaders/loading_animate.dart';
import 'package:adminpickready/features/admin/controllers/dashboard/dashboard_controller.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:adminpickready/utils/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentStatusPieChart extends StatelessWidget {
  const StudentStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => controller.studentStatusData.isNotEmpty
              ? SizedBox(
                height: 400,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: SDeviceUtils.isTabletScreen(context) ? 80 : 55,
                    startDegreeOffset: 180,
                    sections: controller.studentStatusData.entries.map((entry) {
                      final StudentStatus status = entry.key;
                      final int count = entry.value;

                      return PieChartSectionData(
                        showTitle: true,
                        color: SHelperFunctions.getStudentStatusColor(status),
                        value: count.toDouble(),
                        title: '$count',
                        radius: SDeviceUtils.isTabletScreen(context) ? 80 : 100,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: SColors.white),
                      );
                    }).toList(),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse){
                        // Handle touch events here if needed
                      },
                      enabled: true
                    )
                  )
                ),
              )
            : const SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SLoadingAnimate()])),
        ),

        SizedBox(
          width: double.infinity,
          child: Obx(
            () => DataTable(
              columns: const[
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Students')),
                // DataColumn(label: Text('Total'))
              ], 
              rows: controller.studentStatusData.entries.map((entry){
                final StudentStatus status = entry.key;
                final int count = entry.value;
                // final double totalAmount = controller.totalStudent[status]!;
                final String displayStatus = controller.getDisplayStatusName(status);

                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          SCircularContainer(width: 20, height: 20, backgroundColor: SHelperFunctions.getStudentStatusColor(status)),
                          Expanded(child: Text(' $displayStatus')),
                        ],
                      ),
                    ),
                    DataCell(Text(count.toString())),
                    // DataCell(Text('\$${totalAmount.toStringAsFixed(2)}')),
                  ]
                );
              }).toList(),
            )
          ),
        )
      ],
    );
  }
}