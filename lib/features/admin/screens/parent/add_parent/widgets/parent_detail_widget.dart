import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/admin/controllers/parent/addParent_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class ParentDetail extends StatelessWidget {
  const ParentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddParentController());
    return SRoundedContainer(
      
      child: Form(
        key: controller.parentDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Parent Detail', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: SSizes.spaceBtwItems),

            // Parent Input Field
            TextFormField(
              controller: controller.parentFirstName,
              validator: (value) => SValidator.validateEmptyText('Parent First Name', value),
              decoration: const InputDecoration(labelText: 'Parent First Name'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.parentLastName,
              validator: (value) => SValidator.validateEmptyText('Parent Last Name', value),
              decoration: const InputDecoration(labelText: 'Parent Last Name'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.parentPhoneNumber,
              validator: (value) => SValidator.validatePhoneNumber('Phone Number'),
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.parentEmail,
              validator: (value) => SValidator.validateEmptyText('Parent Email', value),
              decoration: const InputDecoration(labelText: 'Parent Email'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            TextFormField(
              // obscureText: controller.hidePassword.value,
              controller: controller.parentPassword,
              validator: (value) => SValidator.validatePassword('Password'),
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),
          ],
        )
      ),
    );
  }
}