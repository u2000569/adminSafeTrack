import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/admin/controllers/teacher/add_teacher_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TeacherBottomNavigationButtons extends StatelessWidget {
  const TeacherBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard Button
          OutlinedButton(
            onPressed: (){
            // Add functionality to discard changes if needed
            },
            child: const Text('Discard'),
          ),

          const SizedBox(width: SSizes.spaceBtwItems / 2),

          // Save changes button
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => AddTeacherController.instance.addTeacher(), 
              child: const Text('Save Changes'),
            ),
          )
        ],
      ),
    );
  }
}