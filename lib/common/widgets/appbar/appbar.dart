import 'package:flutter/material.dart';
import 'package:lit_express/utils/constants/colors.dart';
import 'package:lit_express/utils/constants/sizes.dart';
import 'package:lit_express/utils/device/device_utility.dart';
import '../../../utils/helper/helper_functions.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    required this.appIcon,
    required this.title,
    this.avatar,
  });

  final String appIcon;
  final String title;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(
            appIcon,
            width: TSizes.xl,
            height: TSizes.xl,
          ),
          const SizedBox(width: TSizes.spaceBtwItems,),
          Text(title, style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? TColors.darkGrey : TColors.white)),

        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtility.getAppBarHeight());
}
