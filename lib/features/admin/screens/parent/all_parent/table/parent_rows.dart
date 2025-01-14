import 'package:adminpickready/features/admin/controllers/parent/parent_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../common/widgets/images/s_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class ParentRows extends DataTableSource {
  final controller = ParentController.instance;

  @override 
  DataRow? getRow(int index) {
    final parent = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(SRoutes.parent, arguments: parent),
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
                image: parent.profilePicture,
                imageType: ImageType.network,
                borderRadius: SSizes.borderRadiusMd,
                backgroundColor: SColors.primaryBackground,
              ),
              const SizedBox(width: SSizes.spaceBtwItems,),
              Expanded(
                child: Text(
                  parent.fullName,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: SColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ),
            ],
          )
        ),
        DataCell(Text(parent.email)),
        DataCell(Text(parent.phoneNumber)),
        // DataCell(Text(parent.createdAt == null ? '' : parent.formattedDate)),
        DataCell(
          STableActionButtons(
            view: false,
            edit: false,
            // onViewPressed: () => Get.toNamed(SRoutes.parent, arguments: parent),
            onDeletePressed: () => controller.confirmAndDeleteItem(parent),
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