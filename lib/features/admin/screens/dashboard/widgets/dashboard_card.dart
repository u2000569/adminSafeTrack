import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/icons/s_circular_icon.dart';
import 'package:adminpickready/common/widgets/texts/section_heading.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class SDashboardCard extends StatelessWidget {
  const SDashboardCard({
    super.key, 
    required this.context, 
    required this.title, 
    required this.subTitle, 
    this.icon = Iconsax.arrow_up_3, 
    required this.headingIcon, 
    this.color = SColors.success, 
    required this.headingIconColor, 
    required this.headingIconBgColor, 
    required this.stats, 
    this.onTap
  });

  final BuildContext context;
  final String title, subTitle;
  final IconData icon, headingIcon;
  final Color color, headingIconColor, headingIconBgColor;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SRoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(SSizes.lg),
      child: Column(
        children: [
          //Heading
          Row(
            children: [
              SCircularIcon(
                icon: headingIcon,
                backgroundColor: headingIconBgColor,
                color: headingIconColor,
                size: SSizes.md,
              ),
              const SizedBox(width: SSizes.spaceBtwItems,),
              SSectionHeading(title: title, textColor: SColors.textSecondary,),
              ],
          ),
          const SizedBox(height: SSizes.spaceBtwSections,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subTitle, style: Theme.of(context).textTheme.headlineMedium
              ),

              /// Right Side Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Indicator
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(icon, color: color, size: SSizes.iconSm,),
                        Text(
                          '$stats',
                          style: Theme.of(context).textTheme.titleLarge!.apply(color: color, overflow: TextOverflow.ellipsis),
                        )
                        ],
                    ),
                  ),
                  SizedBox(
                    width: 135,
                    child: Text(
                      'On December 2024',
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ]
          )
        ],
      ),
    );
  }
}