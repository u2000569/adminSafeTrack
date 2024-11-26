import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/shimmers/shimmer.dart';
import 'package:adminpickready/features/admin/controllers/student/add_student_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/grade/grade_controller.dart';

class StudentGrade extends StatelessWidget {
  const StudentGrade({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddStudentController());
    final gradeController = Get.put(GradeController());

    // Fetch grades if the list is empty
    if(gradeController.allItems.isEmpty){
      gradeController.fetchItems();
    }

    return SRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Grade Label
          Text('Grade' , style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SSizes.spaceBtwItems),

          // Type a head field for grade selection
          Obx(
            () => gradeController.isLoading.value
            ? const  SShimmer(width: double.infinity, height: 50)
            : TypeAheadField(
              builder: (context, ctr, focusNode){
                return TextFormField(
                  focusNode: focusNode,
                  controller: controller.gradeTextField = ctr,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Grade',
                    suffixIcon: Icon(Iconsax.pen_add1)
                  ),
                );
              },
              suggestionsCallback: (pattern){
                // Return filtered brand suggestions based on the search pattern
                return gradeController.allItems.where((grade) => grade.name.contains(pattern)).toList();
              },
              itemBuilder: (context, suggestion){
                return ListTile(
                  title: Text(suggestion.name),
                );
              },
              onSelected: (suggestion){
                controller.selectGrade.value = suggestion;
                controller.gradeTextField.text = suggestion.name;
              },
            )
          ),
        ],
      ),
    );
  }
}