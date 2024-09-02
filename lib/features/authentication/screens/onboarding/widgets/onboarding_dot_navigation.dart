import 'package:flutter/material.dart';
import 'package:lit_express/features/authentication/controllers/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    final controller = OnBoardingController.instance;
    return Positioned(
      bottom: TDeviceUtility.getBottomNavigationBarHeight() + 25,
      left: TSizes.spaceDefault,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: const ExpandingDotsEffect(
            activeDotColor: TColors.primaryColor,
            dotHeight: 8
        ),
      ),
    );
  }
}