import 'package:adminpickready/features/media/controllers/media_controller.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaFolderDropdown extends StatelessWidget {
  const MediaFolderDropdown({super.key, this.onChanged});

  final void Function(MediaCategory?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => SizedBox(
        width: 140,
        child: DropdownButtonFormField<MediaCategory>(
          isExpanded: false,
          onChanged: onChanged,
          value: controller.selectedPath.value,
          items: MediaCategory.values.map(
            (category){
              return DropdownMenuItem<MediaCategory>(
                value: category,
                child: Text(category.name.capitalize.toString()),
              );
            },
          ).toList(),
        ),
      )
    );
  }
}