import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SLoginHeader extends StatelessWidget {
  const SLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(width: 100, height: 100,image: AssetImage(SImages.darkAppLogo)),
          const SizedBox(height: SSizes.spaceBtwSections),
          Text(STexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: SSizes.sm),
          Text(STexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium,)
        ],
      ),
    );
  }
}