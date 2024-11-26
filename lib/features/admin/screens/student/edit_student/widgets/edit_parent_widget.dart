import 'package:adminpickready/common/widgets/shimmers/shimmer.dart';
import 'package:adminpickready/features/admin/controllers/parent/parent_controller.dart';
import 'package:adminpickready/features/admin/controllers/student/edit_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';

class StudentParent extends StatelessWidget {
  const StudentParent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditStudentController());
    final parentController = Get.put(ParentController());

    // fetch parent if the list empty
    if(parentController.allItems.isEmpty){
      parentController.fetchItems();
    }

    return SRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Parent label
          Text('Parent', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SSizes.spaceBtwItems),

          // TypeAheadField for brand selection
          Obx(
            () => parentController.isLoading.value
                ? const SShimmer(width: double.infinity, height: 50)
                : TypeAheadField(
                    controller: controller.parentTextField,
                    builder: (context, ctr, focusNode) {
                      return TextFormField(
                        focusNode: focusNode,
                        controller: ctr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select Parent',
                          suffixIcon: Icon(Iconsax.box),
                        ),
                      );
                    },
                    suggestionsCallback: (pattern) {
                      // Return filtered brand suggestions based on the search pattern
                      return parentController.allItems.where((parent) => parent.fullName.contains(pattern)).toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.fullName),
                      );
                    },
                    onSelected: (suggestion) {
                      controller.selectedParent.value = suggestion;
                      controller.parentTextField.text = suggestion.fullName;
                    },
                  ),
          ),
        ],
      ),
    );
  }
}