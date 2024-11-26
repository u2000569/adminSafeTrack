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
          OutlinedButton(onPressed: (){}, child: const Text('Discard')),

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
}