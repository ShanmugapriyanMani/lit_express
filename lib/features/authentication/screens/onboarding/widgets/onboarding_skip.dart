
import 'package:flutter/material.dart';
import 'package:lit_express/features/authentication/controllers/onboarding_controller.dart';
import 'package:lit_express/utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtility.getAppBarHeight(),
        right: TSizes.spaceBtwItems,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states) => Colors.green.withOpacity(0.1)),
          ),
          child: const Text("Skip", style:
            TextStyle(
              fontSize: TSizes.fontSizeMedium,
              color: TColors.secondaryColor,
            ),
          ),
        ),
    );
  }
}