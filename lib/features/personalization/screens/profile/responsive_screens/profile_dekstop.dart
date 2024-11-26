import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/features/personalization/screens/profile/widgets/profile_form.dart';
import 'package:adminpickready/features/personalization/screens/settings/widgets/image_meta.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              SBreadcrumbWithHeading(heading: 'Profile', breadcrumbItems: ['Profile']),
              SizedBox(height: SSizes.spaceBtwSections),

              // BOdy
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic and Meta
                  Expanded(child: ImageAndMeta()),
                  SizedBox(width: SSizes.spaceBtwSections),

                  //Form
                  Expanded(flex:2 ,child: ProfileForm()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}