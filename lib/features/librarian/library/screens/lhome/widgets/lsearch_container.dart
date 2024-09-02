import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/librarian/library/screens/lfilter/lfilter_screen.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/helper/helper_functions.dart';
import '../../lsearch/lsearch_screen.dart';

class LSearchContainer extends StatelessWidget {
  const LSearchContainer({
    super.key,
    required this.text,
    this.searchIcon = Iconsax.search_normal_copy,
    this.filterIcon = Iconsax.sort,
    this.showBackground = true,
    this.showBorder = true
  });

  final String text;
  final IconData? searchIcon;
  final IconData? filterIcon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
      child: Container(
        width: TDeviceUtility.getScreenWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
        decoration: BoxDecoration(
          color: showBackground ? dark ? TColors.dark : TColors.light : Colors.transparent,
          borderRadius: BorderRadius.circular(TSizes.searchBarRadius),
          border: showBorder ? Border.all(color: TColors.grey) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(searchIcon, color: TColors.darkGrey,),
            const SizedBox(width: TSizes.spaceBtwItems,),
            SizedBox(
              width: TSizes.searchBookFieldWidth,
              height: TSizes.searchBookFieldHeight,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: dark ? TColors.grey.withOpacity(0.2) : TColors.grey,
                  splashColor: dark ? TColors.grey.withOpacity(0.2) : TColors.grey,
                  onTap: () {
                    Get.to(() => const LSearchScreen());
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: dark ? TColors.grey.withOpacity(0.2) : TColors.grey.withOpacity(0.9),
                  splashColor: dark ? TColors.grey.withOpacity(0.2) : TColors.grey.withOpacity(0.9),
                  onTap: () {if (kDebugMode) {
                    print("test");
                  }},
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: IconButton(
                      onPressed: () {
                        Get.to(() => const LFilterScreen());
                        },
                      icon: Icon(filterIcon, color: TColors.darkGrey.withOpacity(0.8), size: 25,),
                    ),
                  ),
                ),
              ),
            ),
            // Icon(filterIcon, color: TColors.darkGrey.withOpacity(0.8), size: 25,),
          ],
        ),
      ),
    );
  }
}