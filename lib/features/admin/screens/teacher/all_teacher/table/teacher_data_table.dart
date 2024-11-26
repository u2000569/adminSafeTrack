import 'package:adminpickready/common/widgets/data_table/paginated_data_table.dart';
import 'package:adminpickready/features/admin/controllers/teacher/teacher_controller.dart';
import 'package:adminpickready/features/admin/screens/teacher/all_teacher/table/teacher_rows.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TeacherTable extends StatelessWidget {
  const TeacherTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherController());
    return Obx(
      (){
        // Teachers & Selected Rows are Hidden => Just to update the UI => Obx => [ProductRows]
        Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        // Table
        return SPaginatedDataTable(
          minWidth: 700,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(label: const Text('Teacher'), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
            const DataColumn2(label: Text('Email')),
            const DataColumn2(label: Text('Phone Number')),
            // const DataColumn2(label: Text('Registered')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: TeacherRows(), 
          
        );
      }
    );
  }
}