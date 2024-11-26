import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/admin/controllers/teacher/add_teacher_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherDetail extends StatelessWidget {
  const TeacherDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTeacherController());
    return SRoundedContainer(
      child: Form(
        key: controller.teacherDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Teacher Detail', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: SSizes.spaceBtwItems),

            // Teacher Input Field
            TextFormField(
              controller: controller.teacherFirstName,
              validator: (value) => SValidator.validateEmptyText('Teacher First Name', value),
              decoration: const InputDecoration(labelText: 'Teacher First Name'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.teacherLastName,
              validator: (value) => SValidator.validateEmptyText('Teacher Last Name', value),
              decoration: const InputDecoration(labelText: 'Teacher Last Name'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.teacherPhoneNumber,
              validator: (value) => SValidator.validatePhoneNumber('Phone Number'),
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.teacherEmail,
              validator: (value) => SValidator.validateEmptyText('Teacher Email', value),
              decoration: const InputDecoration(labelText: 'Teacher Email'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            TextFormField(
              // obscureText: controller.hidePassword.value,
              controller: controller.teacherPassword,
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