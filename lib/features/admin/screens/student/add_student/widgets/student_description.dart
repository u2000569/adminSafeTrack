import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/admin/controllers/student/add_student_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentNameAndDescription extends StatelessWidget {
  const StudentNameAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddStudentController());
    return SRoundedContainer(
      child: Form(
        key: controller.studentDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Text
            Text('Basic Info', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: SSizes.spaceBtwItems,),

            // Student Name Input Field
            TextFormField(
              controller: controller.studentName,
              validator: (value) => SValidator.validateEmptyText('Student Name', value),
              decoration: const InputDecoration(labelText: 'Student Name'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

             // Student Matric Number
            TextFormField(
              controller: controller.studentMatric,
              validator: (value) => SValidator.validateEmptyText('Matric Number', value),
              decoration: const InputDecoration(labelText: 'Matric Number'),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            // Student Description Input Field
            // SizedBox(
            //   height: 300,
            //   child: TextFormField(
            //     expands: true,
            //     maxLines: null,
            //     textAlign: TextAlign.start,
            //     controller: controller.description,
            //     keyboardType: TextInputType.multiline,
            //     textAlignVertical: TextAlignVertical.top,
            //     validator: (value) => SValidator.validateEmptyText('Student Description', value),
            //     decoration: const InputDecoration(
            //       labelText: 'Student Description',
            //       hintText: 'Add Student Info here...',
            //       alignLabelWithHint: true,
            //     ),
            //   ),
            // )
          ],
        )
      ),
    );
  }
}