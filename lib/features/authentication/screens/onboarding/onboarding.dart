import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lit_express/features/authentication/controllers/onboarding_controller.dart';
import 'package:lit_express/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:lit_express/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:lit_express/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:lit_express/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:lit_express/utils/constants/text_strings.dart';
import 'package:lit_express/utils/constants/image_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(image: TImages.onBoardingAnimation1, title: TText.onBoardingTitle1, subTitle: TText.onBoardingSubTitle1,),
              OnBoardingPage(image: TImages.onBoardingAnimation2, title: TText.onBoardingTitle2, subTitle: TText.onBoardingSubTitle2,),
              OnBoardingPage(image: TImages.onBoardingAnimation3, title: TText.onBoardingTitle3, subTitle: TText.onBoardingSubTitle3,),
            ],
          ),
          const OnBoardingSkip(),

          const OnBoardingDotNavigation(),
          
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}





