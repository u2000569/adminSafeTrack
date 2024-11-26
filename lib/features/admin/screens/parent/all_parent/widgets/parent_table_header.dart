import 'package:adminpickready/features/admin/controllers/parent/parent_controller.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../routes/routes.dart';

class ParentTableHeader extends StatelessWidget {
  const ParentTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParentController());
    return Row(
      children: [
        Expanded(
          flex: !SDeviceUtils.isDesktopScreen(context) ? 0 : 3,
          child: Row(
            children: [
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(SRoutes.addParent),
                  child: const Text("Add New Parent"),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: SDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(hintText: 'Search Parent', prefixIcon: Icon(Iconsax.search_normal3)),
          )
        )
      ],
    );
  }
}