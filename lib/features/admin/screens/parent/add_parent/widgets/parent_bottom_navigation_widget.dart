import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/admin/controllers/parent/addParent_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';

class ParentBottomNavigationButtons extends StatelessWidget {
  const ParentBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard Button
          OutlinedButton(onPressed: (){
            _discardChanges(context);
          }, child: const Text('Discard')),

          const SizedBox(width: SSizes.spaceBtwItems / 2),

          // Save changes button
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => AddParentController.instance.addParent(), 
              child: const Text('Save Changes'),
            ),
          ) 
        ],
      ),
    );
  }

  void _discardChanges(BuildContext context){
    final controller = AddParentController.instance;

    bool hasUnsavedChanges = 
      controller.parentFirstName.text.isNotEmpty ||
      controller.parentLastName.text.isNotEmpty ||
      controller.parentPhoneNumber.text.isNotEmpty ||
      controller.parentEmail.text.isNotEmpty ||
      controller.parentPassword.text.isNotEmpty;

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
                    controller.parentFirstName.clear();
                    controller.parentLastName.clear();
                    controller.parentPhoneNumber.clear();
                    controller.parentEmail.clear();
                    controller.parentPassword.clear();
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