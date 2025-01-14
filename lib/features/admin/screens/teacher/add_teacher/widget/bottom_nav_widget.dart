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
            _discardChanges(context);
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

  void _discardChanges(BuildContext context){
    final controller = AddTeacherController.instance;

    bool hasUnsavedChanges = 
      controller.teacherFirstName.text.isNotEmpty ||
      controller.teacherLastName.text.isNotEmpty ||
      controller.teacherPhoneNumber.text.isNotEmpty ||
      controller.teacherEmail.text.isNotEmpty ||
      controller.teacherPassword.text.isNotEmpty;

      if (hasUnsavedChanges) {
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Discard Changes'),
              content: const Text('Are you sure you want to discard changes?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    controller.teacherFirstName.clear();
                    controller.teacherLastName.clear();
                    controller.teacherPhoneNumber.clear();
                    controller.teacherEmail.clear();
                    controller.teacherPassword.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Discard'),
                )
              ],
            );
          }
        );
      } else{
        Navigator.pop(context);
      }
  }
}