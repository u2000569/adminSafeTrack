import 'package:adminpickready/features/admin/controllers/grade/grade_controller.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class GradeTableHeader extends StatelessWidget {
  const GradeTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GradeController());
    return Row(
      children: [
        Expanded(
          flex: !SDeviceUtils.isDesktopScreen(context) ? 1:3,
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(onPressed: () =>  Get.toNamed(SRoutes.createGrade), child: const Text('Create New Grade'),),
              ),
            ],
          )
        ),
        Expanded(
          flex: !SDeviceUtils.isDesktopScreen(context) ? 2:1,
          child: TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(hintText: 'Search Grade', prefixIcon: Icon(Iconsax.search_normal2)),
          ),
        )
      ],
    );
  }
}