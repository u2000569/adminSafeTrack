import 'package:adminpickready/features/admin/controllers/teacher/teacher_controller.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TeacherTableHeader extends StatelessWidget {
  const TeacherTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherController());
    return Row(
      children: [
        Expanded(flex: !SDeviceUtils.isDesktopScreen(context) ? 0 : 3, 
        // child: const SizedBox(),),
        child:Row(
          children: [
            SizedBox(
              width: 140,
              child: ElevatedButton(onPressed: () => Get.toNamed(SRoutes.addTeacher),child: const Text("Add New Teacher") ,),
            )
          ],
        )
        ), 
        Expanded(
          flex: SDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(hintText: 'Search Teacher', prefixIcon: Icon(Iconsax.search_normal3)),
          )
        )
      ],
    );
  }
}