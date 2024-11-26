import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../widgets/parent_bottom_navigation_widget.dart';
import '../widgets/parent_detail_widget.dart';

class AddParentDesktopScrenn extends StatelessWidget {
  const AddParentDesktopScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: ParentBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // breadcrumbs
              SBreadcrumbWithHeading(
                heading: 'Parent', 
                breadcrumbItems: [SRoutes.parent, 'Parent']
              ),
              SizedBox(height: SSizes.spaceBtwSections,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ParentDetail(),
                        SizedBox(height: SSizes.spaceBtwSections),
                      ],
                    )
                  )
                ],
              )
            ],
          ),
          ),
      ),
    );
  }
}