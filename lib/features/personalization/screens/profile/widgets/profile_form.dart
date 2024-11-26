import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/personalization/controllers/user_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Column(
      children: [
        SRoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: SSizes.lg, horizontal: SSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile Details', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: SSizes.spaceBtwSections),

              // First Last Name
              Form(
                key: controller.formKey,
                child: Column(
                  children:[
                    Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.firstNameController,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                            label: Text('First Name'),
                            prefixIcon: Icon(Iconsax.user),
                          ),
                          validator: (value) => SValidator.validateEmptyText('First Name', value),
                        ),
                      ),
                      const SizedBox(width: SSizes.spaceBtwInputFields),
                      // Last Name
                      Expanded(
                        child: TextFormField(
                          controller: controller.lastNameController,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                            label: Text('Last Name'),
                            prefixIcon: Icon(Iconsax.user),
                          ),
                          validator: (value) => SValidator.validateEmptyText('Last Name', value),
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: SSizes.spaceBtwInputFields),

                  //Email and Phone
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                        
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            label: Text('Email'),
                            prefixIcon: Icon(Iconsax.forward),
                            enabled: false,
                          ),
                          initialValue: UserController.instance.user.value.email,
                        ),
                      ),
                      const SizedBox(width: SSizes.spaceBtwItems),
                      // Last Name
                      Expanded(
                        child: TextFormField(
                          controller: controller.phoneController,
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                            label: Text('Phone Number'),
                            prefixIcon: Icon(Iconsax.mobile),
                          ),
                          validator: (value) => SValidator.validateEmptyText('Phone Number', value),
                        )
                      ),
                    ],
                  ),
                  ] 
                ),
              ),

              const SizedBox(height: SSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                      onPressed: () => controller.loading.value ? () {} : controller.updateUserInformation(),
                      child: controller.loading.value
                          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                          : const Text('Update Profile'),
                    )
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}