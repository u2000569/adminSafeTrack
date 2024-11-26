import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:adminpickready/common/widgets/images/s_rounded_image.dart';
import 'package:adminpickready/features/admin/controllers/student/student_controller.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentsRows extends DataTableSource {
  final controller = StudentController.instance;

  @override
  DataRow? getRow(int index){
    final student = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(SRoutes.editStudent, arguments: student),
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              SRoundedImage(
                width: 50,
                height: 50,
                padding: SSizes.xs,
                image: student.thumbnail,
                imageType: ImageType.network,
                borderRadius: SSizes.borderRadiusMd,
                backgroundColor: SColors.primaryBackground,
              ),
              const SizedBox(width: SSizes.spaceBtwItems),
              Flexible(child: Text(student.name, style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: SColors.primary),)),
            ],
          )
        ),
        DataCell(
          Row(
            children: [
              Flexible(
                child: Text(student.id, style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: SColors.textPrimary),)
              )
            ],
          )
          ),
        DataCell(
          Row(
            children: [
              SRoundedImage(
                width: 35,
                height: 35,
                padding: SSizes.xs,
                borderRadius: SSizes.borderRadiusMd,
                backgroundColor: SColors.primaryBackground,
                imageType: student.grade != null ? ImageType.network : ImageType.asset,
                image: student.grade != null ? student.grade!.image : SImages.defaultImage,
              ),
              const SizedBox(width: SSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  // student.grade != null ? student.grade!.name : '',
                  student.grade?.name ?? 'N/A',
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: SColors.primary),
                )
              ),
            ],
          )
        ),
        DataCell(SRoundedContainer(
            radius: SSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(vertical: SSizes.sm, horizontal: SSizes.md),
            backgroundColor: SHelperFunctions.getStudentStatusColor(student.status).withOpacity(0.1),
            child: Text(
              student.status.name.capitalize.toString(),
              style: TextStyle(color: SHelperFunctions.getStudentStatusColor(student.status)),
            ),
          )
        ),
        DataCell(Text(student.formattedAttendanceDate)),
        DataCell(STableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(SRoutes.studentDetail, arguments: student),
            onDeletePressed: () => controller.confirmAndDeleteItem(student),
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