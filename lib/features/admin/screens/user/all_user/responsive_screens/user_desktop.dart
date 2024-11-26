import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/features/personalization/controllers/user_controller.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDesktopScreen extends StatelessWidget {
  const UserDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const SBreadcrumbWithHeading(heading: 'User', breadcrumbItems: ['User']),
              const SizedBox(height: SSizes.spaceBtwSections,),

              
            ],
          ),
        ),
      ),
    );
  }
}