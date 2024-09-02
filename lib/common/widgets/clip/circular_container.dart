import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.child,
    this.width = 150,
    this.height = 150,
    this.radius = 100,
    this.padding = 0,
    this.backgroundColor = TColors.white
  });

  final Widget? child;
  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}