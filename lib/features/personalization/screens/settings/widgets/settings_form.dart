import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/settings_controller.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Column(
      children: [
        // App Settings
        SRoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: SSizes.lg, horizontal: SSizes.md),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App Settings', style: Theme.of(context).textTheme.headlineSmall,),
                const SizedBox(height: SSizes.spaceBtwSections,),

                // App Name
                TextFormField(
                  controller: controller.appNameController,
                  decoration: const InputDecoration(
                    hintText: 'App Name',
                    label: Text('Safe Track'),
                    prefixIcon: Icon(Iconsax.user)
                  ),
                ),
                const SizedBox(height: SSizes.spaceBtwInputFields,),

                // Email and Phone
                Row(
                  children: [
                    // First Name
                    Expanded(
                      child: TextFormField(
                        // controller: controller.,
                        decoration: const InputDecoration(
                          hintText: 'Setting',
                          label: Text('Setting'),
                          prefixIcon: Icon(Iconsax.tag),
                        ),
                      ),
                    ),
                    const SizedBox(width: SSizes.spaceBtwItems),
                    // Last Name
    
                  ],
                ),

                const SizedBox(height: SSizes.spaceBtwInputFields * 2),

                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () => controller.loading.value ? () {} : controller.updateSettingInformation(),
                      child: controller.loading.value
                          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                          : const Text('Update App Settings'),
                    ),
                  ),
                )
              ],
            ),
            ),
        )
      ],
    );
  }
}