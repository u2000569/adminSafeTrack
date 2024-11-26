import 'package:flutter/material.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class SLoadingAnimate extends StatelessWidget {
  const SLoadingAnimate({
    super.key, 
    this.height = 300, 
    this.width = 300
  });

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image(image: const AssetImage(SImages.ridingIllustration), height: height, width: width),
          const SizedBox(height: SSizes.spaceBtwItems),
          const Text('Loading your data...'),
        ],
      ),
    );
  }
}