import 'package:adminpickready/common/widgets/chips/rounded_choice_chips.dart';
import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/features/admin/controllers/category/category_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/grade/create_grade_controller.dart';

class CreateGradeForm extends StatelessWidget {
  const CreateGradeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateGradeController());
    return SRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(SSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: SSizes.sm),
            Text('Create New Grade', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: SSizes.spaceBtwSections),

            // Name text field
            TextFormField(
              controller: controller.name,
              validator: (value) => SValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(labelText: 'Grade Name', prefixIcon: Icon(Iconsax.box2)),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            // categories
            // Text('Select Categories', style: Theme.of(context).textTheme.titleMedium,),
            // const SizedBox(height: SSizes.spaceBtwInputFields / 2),
            // Obx(() => Wrap(
            //   spacing: SSizes.sm,
            //   children: CategoryController.instance.allItems
            //         .map((element) => Padding(
            //           padding: const EdgeInsets.only(bottom: SSizes.sm),
            //             child: SChoiceChip(
            //             text: element.name,
            //             selected: controller.selectedCategories.contains(element),
            //             onSelected: (value) => controller.toggleSelection(element),
            //             ),
            //           )
            //         )
            //         .toList(),
            //   )
            // ),

            const SizedBox(height: SSizes.spaceBtwInputFields * 2),
            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(seconds: 2),
                child: controller.loading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: () => controller.createGrade(), child: const Text('Create'),),
                    )
              )
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields * 2),
          ],
        )
        ),
    );
  }
}