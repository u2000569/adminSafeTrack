import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/create_grade_form.dart';

class CreateGradeDesktopScreen extends StatelessWidget {
  const CreateGradeDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              SBreadcrumbWithHeading(
                returnToPreviousScreen: true, heading: 'Create Grade', breadcrumbItems: [SRoutes.grade, 'Create Grade']),
              SizedBox(height: SSizes.spaceBtwSections,),

              //Form
              CreateGradeForm(),
            ],
          ),
        ),
      ),
    );
  }
}