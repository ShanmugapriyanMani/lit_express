import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Image(
              image: AssetImage(TImages.appLogo),
              height: 70,
            ),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Text(TText.appName2, style: Theme.of(context).textTheme.headlineLarge,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwHeader,),
        Text(TText.loginTitle, style: Theme.of(context).textTheme.headlineMedium,),
        const SizedBox(height: TSizes.sm,),
        Text(TText.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium,),
      ],
    );
  }
}