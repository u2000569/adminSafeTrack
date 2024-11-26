import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SPageNotFound extends StatelessWidget {
  const SPageNotFound({
    super.key,
    this.isFullPage = false,
    this.title = 'Well, This is Awkward...',
    this.subTitle =
    'It seems we couldn’t find any records here. Maybe they’re off on an adventure or just hiding really well. Try again or check back later!'
  });

  final bool isFullPage;
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return SSiteTemplate(
      useLayout: !isFullPage,
      desktop: Center(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(width: 400, height: 400, child: Image(image: AssetImage(SImages.errorIllustration))),
              const SizedBox(height: SSizes.spaceBtwItems,),
              Text(title, style: Theme
                .of(context)
                .textTheme
                .headlineLarge, textAlign: TextAlign.center),
              const SizedBox(height: SSizes.spaceBtwItems),
              Text(subTitle, textAlign: TextAlign.center),
              const SizedBox(height: SSizes.spaceBtwSections,),
              SizedBox(
                width: 250,
                child: ElevatedButton.icon(
                  onPressed: () => Get.offAllNamed(SRoutes.dashboard),
                  label: const Text('Take Me Home!'),
                  icon: const Icon(Iconsax.home),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}