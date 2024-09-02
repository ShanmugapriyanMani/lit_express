import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lit_express/utils/constants/image_strings.dart';
import 'package:lit_express/utils/helper/helper_functions.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'animation_loader.dart';

class TFullScreenLoader {

  /// Open loading dialog
  static void openLoadingScreen(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: TAnimationLoaderWidget(
            text: text,
            animation: animation,
          ),
        ),
      ),
    );
  }

  /// stop loading
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }

  static Widget bookLoader() {
    return Expanded(
      child: Center(
        child: Lottie.asset(
          TImages.loadingAnimation,
          height: TSizes.loadingHeight,
          width: TSizes.loadingWidth,
          alignment: Alignment.center,
        )
      ),
    );
  }
}