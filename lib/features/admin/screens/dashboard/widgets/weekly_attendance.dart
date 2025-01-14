import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/icons/s_circular_icon.dart';
import 'package:adminpickready/common/widgets/loaders/loading_animate.dart';
import 'package:adminpickready/features/admin/controllers/dashboard/dashboard_controller.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SWeeklyAttendanceGraph extends StatelessWidget {
  const SWeeklyAttendanceGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return SRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SCircularIcon(
                icon: Iconsax.graph,
                backgroundColor: Colors.brown.withOpacity(0.1),
                color: Colors.brown,
                size: SSizes.md,
              ),
              const SizedBox(width: SSizes.spaceBtwItems),
              Text('Weekly Attendance', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: SSizes.spaceBtwSections),

          // Graph
          Obx(
            () => controller.weeklyAttendance.isNotEmpty
                  ? SizedBox(
                    height: 400,
                    child: BarChart(
                      BarChartData(
                        titlesData: buildFlTitlesData(controller.weeklyAttendance),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(top: BorderSide.none, right: BorderSide.none), 
                        ),
                        gridData: const FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: true, // Remove vertical lines
                          horizontalInterval: 200, 
                        ),
                        barGroups: controller.weeklyAttendance
                                  .asMap().entries.map(
                                    (entry) => BarChartGroupData(
                                      x: entry.key,
                                      barRods: [
                                        BarChartRodData(
                                          width: 30,
                                          toY: entry.value,
                                          color: SColors.primary,
                                          borderRadius: BorderRadius.circular(SSizes.sm),
                                        ),
                                      ],
                                    ),
                                  ).toList(),
                                  groupsSpace: SSizes.spaceBtwItems,
                                  barTouchData: BarTouchData(
                                    touchTooltipData: BarTouchTooltipData(getTooltipColor: (_) => SColors.secondary),
                                    touchCallback: SDeviceUtils.isDesktopScreen(context) ? (barTouchEvent, barTouchResponse) {} : null,
                                  ),
                      )
                    ),
                  )
                  : const SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SLoadingAnimate()])),
          )
        ],
      ),
    );
  }

  FlTitlesData buildFlTitlesData(List<double> weeklyAttendance){
    // Calculate Step height for the left
    double maxStudent = weeklyAttendance.reduce((value, element) => value > element ? value : element).toDouble();
    double stepHeight = (maxStudent / 10).ceilToDouble();
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta){
            // Map index to the desired day of the week
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

            // calculate the index of the day
            final index = value.toInt() % days.length;

            // Get the day corresponding to the index
            final day = days[index];

            // Return a custom widget with the full day name
            return SideTitleWidget(
              space: 0, 
              axisSide: AxisSide.bottom,
              child: Text(day),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: stepHeight == 0 ? 1.0 : stepHeight, reservedSize: 50)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}