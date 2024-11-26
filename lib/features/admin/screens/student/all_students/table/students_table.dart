import 'package:adminpickready/features/admin/controllers/student/student_controller.dart';
import 'package:adminpickready/features/admin/screens/student/all_students/table/table_source.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';

class StudentsTable extends StatelessWidget {
  const StudentsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    return Obx(
      () {
        // Students & Selected Rows are Hidden => Just to update the UI => Obx => [ProductRows]
        Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        // Table
        return SPaginatedDataTable(
          minWidth: 1000,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
              label: const Text('Student'),
              fixedWidth: !SDeviceUtils.isDesktopScreen(context) ? 300:400,
              onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),
            ),
            const DataColumn2(label: Text('Student ID')),
            const DataColumn2(label: Text('Student Grade')),
            const DataColumn2(label: Text('Student Status')),
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: StudentsRows(),
        );
      }
    );
  }
}