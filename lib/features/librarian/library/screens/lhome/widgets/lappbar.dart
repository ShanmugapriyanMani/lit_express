import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/helper/helper_functions.dart';
import '../../../../../member/personalization/screens/profile/profile_screen.dart';

class LAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LAppBar({
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