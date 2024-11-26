import 'package:adminpickready/common/widgets/texts/page_heading.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SBreadcrumbWithHeading extends StatelessWidget {
  const SBreadcrumbWithHeading({
    super.key,
     required this.heading, 
     required this.breadcrumbItems, 
     this.returnToPreviousScreen = false,
  });

  // The heading for the page
  final String heading;

  // List of breadcrumb items representing the navigation path
  final List<String> breadcrumbItems;

  // Flag indicating whether to include a button to return to the previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb
        Row(
          children: [
            // Dashboard Link
            InkWell(
              onTap: () => Get.offAllNamed(SRoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(SSizes.xs),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                ),
              ),
            ),
            // Breadcrumb items
            for (int i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  const Text('/'), // Separator
                  InkWell(
                    // Last item should not be clickable
                    onTap: i == breadcrumbItems.length - 1 ? null : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(SSizes.xs),
                      // Format breadcrumb item: capitalize and remove leading '/'
                      child: Text(
                        i == breadcrumbItems.length - 1
                              ? breadcrumbItems[i].capitalize.toString()
                              : capitalize(breadcrumbItems[i].substring(1)),
                        style: Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
        const SizedBox(height: SSizes.sm,),

        // Heading of the page
        Row(
          children: [
            if(returnToPreviousScreen) IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left)),
            if(returnToPreviousScreen) const SizedBox(width: SSizes.spaceBtwItems,),
            SPageHeading(heading: heading),
          ],
        )
      ],
    );
  }

  // Function to capitalize the first letter of a string
  String capitalize(String s) {
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}