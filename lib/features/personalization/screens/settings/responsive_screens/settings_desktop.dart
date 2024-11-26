import 'package:adminpickready/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/image_meta.dart';
import '../widgets/settings_form.dart';

class SettingDesktopScreen extends StatelessWidget {
  const SettingDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(SSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            SBreadcrumbWithHeading(heading: 'Settings', breadcrumbItems: ['Settings']),
            SizedBox(height: SSizes.spaceBtwSections,),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Pic and Meta
                Expanded(child: ImageAndMeta()),
                SizedBox(width: SSizes.spaceBtwSections,),

                // Form
                Expanded(flex: 2,child: SettingsForm()),
              ],
            )
          ],
        ),
        ),
      ),
    );
  }
}