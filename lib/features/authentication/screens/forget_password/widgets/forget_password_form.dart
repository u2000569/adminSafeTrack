import 'package:adminpickready/features/authentication/controllers/forget_password_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/constants/text_strings.dart';
import 'package:adminpickready/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Headings
        IconButton(onPressed: () => Get.back() , icon: const Icon(Iconsax.arrow_left_2)),
        const SizedBox(height: SSizes.spaceBtwItems),
        Text(STexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: SSizes.spaceBtwItems),
        Text(STexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.bodyMedium!.apply(color: Theme.of(context).colorScheme.secondary)),
        const SizedBox(height: SSizes.spaceBtwSections * 2),

        // Email Field
        Form(
          key: controller.forgetPasswordFormKey,
          child: TextFormField(
            controller: controller.email,
            validator: SValidator.validateEmail,
            decoration: const InputDecoration(labelText: STexts.email, prefixIcon: Icon(Iconsax.direct_right)),
          ) 
        ),
        const SizedBox(height: SSizes.spaceBtwSections),

        //Submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.sendPasswordResetEmail(), child: const Text(STexts.submit),
          ),
        ),
        const SizedBox(height: SSizes.spaceBtwSections * 2),
      ],
    );
  }
}