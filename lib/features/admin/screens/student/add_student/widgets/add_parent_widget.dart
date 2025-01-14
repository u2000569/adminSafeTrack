import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/shimmers/shimmer.dart';
import 'package:adminpickready/features/admin/controllers/parent/parent_controller.dart';
import 'package:adminpickready/features/admin/controllers/student/add_student_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddStudentParent extends StatelessWidget {
  const AddStudentParent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddStudentController());
    final parentController = Get.put(ParentController());

    // Fetch Parents if list is empty
    if(parentController.allItems.isEmpty){
      parentController.fetchItems();
      SLoggerHelper.debug('Fetching Parents Data List');
    }
    return SRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Parent', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SSizes.spaceBtwItems),

          Obx(() => 
            parentController.isLoading.value
            ? const SShimmer(width: double.infinity, height: 50)
            : TypeAheadField(
              builder: (context, ctr, focusNode) {
                return TextFormField(
                  focusNode: focusNode,
                  controller: controller.parentTextField = ctr,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Parent',
                    suffixIcon: Icon(Iconsax.people),
                  ),
                );
              },
              suggestionsCallback: (pattern){
                return parentController.allItems.where((parent) => 
                parent.fullName.contains(pattern)).toList();
              },
              itemBuilder: (context, value) {
                return ListTile(
                  title: Text(value.fullName),
                );
              },
              onSelected: (value) {
                controller.selectParent.value = value;
                controller.parentTextField.text = value.fullName;
              },
            )
          )
        ],
      ),
    );
  }
}