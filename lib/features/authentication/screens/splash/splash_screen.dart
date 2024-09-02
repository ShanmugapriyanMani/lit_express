import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lit_express/utils/constants/image_strings.dart';
import 'package:lit_express/utils/constants/sizes.dart';
import 'package:lit_express/utils/constants/text_strings.dart';
import '../../../../data/repository/authentication_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final authenticationRepository = Get.put(AuthenticationRepository());
    Timer(const Duration(seconds: 3), () async {
      await authenticationRepository.screenRedirect();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(
              TImages.appLogo,
              height: TSizes.appLogoWidth,
              width: TSizes.appLogoHeight,
            ),
            Text(TText.appName1, style: Theme.of(context).textTheme.headlineMedium,)
          ],
        ),
      )
    );
  }
}
