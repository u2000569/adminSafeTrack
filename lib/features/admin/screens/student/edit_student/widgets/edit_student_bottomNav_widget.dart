import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/admin/controllers/student/edit_student_controller.dart';
import 'package:adminpickready/features/admin/models/student_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';

class EditStudentBottomNavButtons extends StatelessWidget {
  const EditStudentBottomNavButtons({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return SRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard Button
          // OutlinedButton(
          //   onPressed: (){
          //   // Add functionality to discard changes if needed
          //   },
          //   child: const Text('Discard'),
          // ),
          // const SizedBox(width: SSizes.spaceBtwItems / 2),

          // Save changes button
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => EditStudentController.instance.editStudent(student), 
              child: const Text('Save Changes'),
            ),
          )
        ],
      ),
    );
  }
}