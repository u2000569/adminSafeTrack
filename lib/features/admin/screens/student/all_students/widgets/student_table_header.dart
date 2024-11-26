import 'package:adminpickready/features/admin/controllers/student/student_controller.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../routes/routes.dart';

class StudentTableHeader extends StatelessWidget {
  const StudentTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    return Row(
      children: [
        Expanded(
          flex: !SDeviceUtils.isDesktopScreen(context) ? 1 : 3,
          child: Row(
            children: [
              SizedBox(
                width: 140,
                child: ElevatedButton(onPressed: () => Get.toNamed(SRoutes.addStudent), child: const Text('Add Students'),),
              )
            ],
          )
        ),
        Expanded(
          flex: SDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(hintText: 'Search Student', prefixIcon: Icon(Iconsax.search_normal2)),
          )
        )
      ],
    );
  }
}