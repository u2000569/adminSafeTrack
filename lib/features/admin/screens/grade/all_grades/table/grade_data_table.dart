import 'package:adminpickready/common/widgets/data_table/paginated_data_table.dart';
import 'package:adminpickready/features/admin/controllers/grade/grade_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'grade_table_source.dart';

class GradeDataTable extends StatelessWidget {
  const GradeDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GradeController());
    return Obx(
      (){
        // Categories & Selected Rows are Hidden => Just to update the UI => Obx => [StudentRows]
        Visibility(visible: false,child: Text(controller.filteredItems.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        final lgTable = controller.filteredItems.any((element) => element.gradeCategories != null && element.gradeCategories!.length > 2);
        // Table
        return SPaginatedDataTable(
          minWidth: 700,
          dataRowHeight: lgTable ? 96 : 64,
          tableHeight: lgTable ? 96 * 11.5 : 760,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          source: GradeRows(), 
          columns: [
            DataColumn2(
              label: const Text('Grade'),
              // fixedWidth: SDeviceUtils.isMobileScreen(Get.context!) ? null : 200,
              onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)
            ),
            // const DataColumn2(label: Text('Categories')),
            const DataColumn2(label: Text('Action')),
          ]
        );
      }
    );
  }
}