import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/constants/sizes.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation
  });

  final String text;
  final String animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Lottie.asset(
          animation,
          height: TSizes.loadingHeight,
          width: TSizes.loadingWidth,
          ),
          const SizedBox(height: TSizes.spaceBtwItems,),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
