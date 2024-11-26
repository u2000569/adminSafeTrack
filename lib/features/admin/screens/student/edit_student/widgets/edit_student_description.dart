import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/admin/controllers/student/edit_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class EditStudentDescription extends StatelessWidget {
  const EditStudentDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditStudentController());
    return SRoundedContainer(
      child: Form(
        key: controller.studentDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information
            Text('Student Information', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: SSizes.spaceBtwItems),

            // Student Input Field
            TextFormField(
              controller: controller.studentName,
              validator: (value) => SValidator.validateEmptyText('Student Name', value),
              decoration: const InputDecoration(labelText: 'Student Name'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.studentID,
              validator: (value) => SValidator.validateEmptyText('Student ID', value),
              decoration: const InputDecoration(labelText: 'Student ID'),
            ),
          ],
        )
        ),
    );
  }
}