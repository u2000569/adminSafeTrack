import 'package:adminpickready/common/widgets/data_table/paginated_data_table.dart';
import 'package:adminpickready/features/admin/controllers/parent/parent_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'parent_rows.dart';

class ParentTable extends StatelessWidget {
  const ParentTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParentController());
    return Obx(
      (){
        Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        return SPaginatedDataTable(
          minWidth: 700,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,

          columns: [
            DataColumn2(label: const Text('Parent'), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
            const DataColumn2(label: Text('Email')),
            const DataColumn2(label: Text('Phone Number')),
            // const DataColumn2(label: Text('Registered')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: ParentRows(),
        );
      }
    );
  }
}