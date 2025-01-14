import 'package:adminpickready/common/widgets/images/s_rounded_image.dart';
import 'package:adminpickready/features/admin/controllers/grade/grade_controller.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class GradeRows extends DataTableSource {
  final controller = GradeController.instance;

  @override
  DataRow? getRow(int index){
    final grade = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        // Grade Name
        DataCell(
          Row(
            children: [
              SRoundedImage(
                width: 50,
                height: 50,
                padding: SSizes.sm,
                image: grade.image,
                imageType: ImageType.network,
                borderRadius: SSizes.borderRadiusMd,
                backgroundColor: SColors.primaryBackground,
              ),
              const SizedBox(width: SSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  grade.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: SColors.primary),
                )
              )
            ],
          )
        ),
        // Categories
        // DataCell(
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: SSizes.sm),
        //     child: SingleChildScrollView(
        //       scrollDirection: Axis.vertical,
        //       child: Wrap(
        //         spacing: SSizes.xs,
        //         direction: SDeviceUtils.isMobileScreen(Get.context!) ? Axis.vertical : Axis.horizontal,
        //         children: grade.gradeCategories != null
        //             ? grade.gradeCategories!
        //               .map((e) => Padding(
        //                 padding:  EdgeInsets.only(bottom: SDeviceUtils.isMobileScreen(Get.context!) ? 0 : SSizes.xs),
        //                 child: Chip(label: Text(e.name), padding: const EdgeInsets.all(SSizes.xs)),
        //               ))
        //               .toList(): [const SizedBox()],
        //       ),
        //     ),
        //   )
        // ),
          DataCell(
            STableActionButtons(
              view: false,
              edit: false,
            //onEditPressed: () => Get.toNamed(SRoutes.editGrade, arguments: grade),
            onDeletePressed: () => controller.confirmAndDeleteGrade(grade),
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