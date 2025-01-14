import 'package:adminpickready/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:adminpickready/common/widgets/images/s_rounded_image.dart';
import 'package:adminpickready/features/admin/controllers/teacher/teacher_controller.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherRows extends DataTableSource {
  final controller = TeacherController.instance;

  @override
  DataRow? getRow(int index){
    final teacher = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(SRoutes.teacher, arguments: teacher), // need to change to edit student 
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              SRoundedImage(
                width: 50,
                height: 50,
                padding: SSizes.sm,
                image: teacher.profilePicture,
                imageType: ImageType.network,
                borderRadius: SSizes.borderRadiusMd,
                backgroundColor: SColors.primaryBackground,
              ),
              const SizedBox(width: SSizes.spaceBtwItems,),
              Expanded(
                child: Text(
                  teacher.fullName,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: SColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ),
            ],
          )
        ),
        DataCell(Text(teacher.email)),
        DataCell(Text(teacher.phoneNumber)),
        // DataCell(Text(teacher.createdAt == null ? '' : teacher.formattedDate)),
        DataCell(
          STableActionButtons(
            view: false,
            edit: false,
            // onViewPressed: () => Get.toNamed(SRoutes.teacher, arguments: teacher),
            onDeletePressed: () => controller.confirmAndDeleteItem(teacher),
          )
        )
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}