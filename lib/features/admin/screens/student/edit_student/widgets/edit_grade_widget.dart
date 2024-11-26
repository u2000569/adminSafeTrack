import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/shimmers/shimmer.dart';
import 'package:adminpickready/features/admin/controllers/grade/grade_controller.dart';
import 'package:adminpickready/features/admin/controllers/student/edit_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';

class EditStudentGrade extends StatelessWidget {
  const EditStudentGrade({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditStudentController());
    final gradeController = Get.put(GradeController());

    //fetch grades if the list empty
    if(gradeController.allItems.isEmpty){
      gradeController.fetchItems();
    }
    return SRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Grade label
          Text('Grade', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SSizes.spaceBtwItems),

          Obx(
            () => gradeController.isLoading.value
                ? const SShimmer(width: double.infinity, height: 50)
                : TypeAheadField(
                  controller: controller.gradeTextField,
                  builder: (context, ctr, focusNode){
                    return TextFormField(
                      controller: ctr,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Select Grade',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                    );
                  },
                  itemBuilder: (context, suggestion){
                    return ListTile(
                      title: Text(suggestion.name),
                    );
                  }, 
                  onSelected: (suggestion){
                    controller.gradeTextField.text = suggestion.name;
                    controller.selectedGrade.value = suggestion;
                  }, 
                  suggestionsCallback: (pattern){
                    return gradeController.allItems.where((grade) => grade.name.contains(pattern)).toList();
                  }
                )
          )
        ],
      ),
    );
  }
}