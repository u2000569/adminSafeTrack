import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/login_contoller.dart';

class SLoginForm extends StatelessWidget {
  const SLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator: SValidator.validateEmail,
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: STexts.email),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields,),

            // Password
            Obx(
              () => TextFormField(
                obscureText: controller.hidePassword.value,
                controller: controller.password,
                validator: (value) => SValidator.validateEmptyText('Password', value),
                decoration: InputDecoration(
                  labelText: STexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            /// Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = value!)),
                    const Text(STexts.rememberMe),
                  ],
                ),

                /// Forget Password
                TextButton(onPressed: () => Get.toNamed(SRoutes.forgetPassword), child: const Text(STexts.forgetPassword)),
              ],
            ),
            const SizedBox(height: SSizes.spaceBtwSections,),
            /// Sign In Button
            SizedBox(
              width: double.infinity,
              // Un Comment this line to register admin
              // child: ElevatedButton(onPressed: () => controller.registerAdmin(), child: const Text('Register Admin')),
              child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn(), 
              child: const Text(STexts.signIn)),
            ),
          ],
        ),
      ),
    );
  }
}