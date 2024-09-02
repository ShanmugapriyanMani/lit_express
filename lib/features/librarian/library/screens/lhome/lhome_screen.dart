import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/librarian/library/controllers/ldetails_request_controller.dart';
import 'package:lit_express/features/librarian/library/screens/lfilter/lfilter_screen.dart';
import 'package:lit_express/features/librarian/library/screens/lhome/widgets/lprimaryheader.dart';
import 'package:lit_express/features/librarian/library/screens/lhome/widgets/pending_request_list.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../../member/personalization/screens/profile/profile_screen.dart';
import '../../controllers/pendig_request_controller.dart';
import '../lapproved/lapproved_screen.dart';


class LHomeScreen extends StatelessWidget {
  const LHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pendingController = Get.put(LPendingRequestController());
    final lDetailsController = Get.put(LDetailsController());
    final dark = THelperFunctions.isDarkMode(context);

    List<Widget> tabItems = [
      const LApprovedScreen(),
      const LHomeBodyWidget(),
      const ProfileScreen()
    ];


    return Scaffold(
        body: Obx(() => tabItems[pendingController.selectedIndex.value],),
        bottomNavigationBar: Obx(() => FlashyTabBar(
          backgroundColor: dark ? TColors.midBlack : TColors.white,
          selectedIndex: pendingController.selectedIndex.value,
          showElevation: true,
          onItemSelected: (index) {
            pendingController.selectedIndex.value = index;
          },
          items: [
            FlashyTabBarItem(
              icon: badges.Badge(
                position: badges.BadgePosition.topEnd(top: 0, end: 0),
                showBadge: lDetailsController.isSlideToApprove.value,
                ignorePointer: lDetailsController.isSlideToApprove.value,
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                badgeStyle: const badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: TColors.primaryColor,
                  padding: EdgeInsets.all(5),
                  borderSide: BorderSide(color: Colors.white, width: 1.5,),
                  elevation: 1,
                ),
                child: const Icon(Iconsax.book, size:   TSizes.bottomNavIconSize, color: TColors.primaryColor,),
              ),
              title: const Text('History', style: TextStyle(color: TColors.primaryColor,),),
              activeColor: TColors.primaryColor,
            ),
            FlashyTabBarItem(
              icon: const Icon(Iconsax.home_2, size: TSizes.bottomNavIconSize, color: TColors.primaryColor,),
              title: const Text('Home', style: TextStyle(color: TColors.primaryColor,),),
              activeColor: TColors.primaryColor,
            ),
            FlashyTabBarItem(
              icon: const Icon(Iconsax.profile_circle, size: TSizes.bottomNavIconSize, color: TColors.primaryColor,),
              title: const Text('Account', style: TextStyle(color: TColors.primaryColor,),),
              activeColor: TColors.primaryColor,
            ),
          ],
        )),
    );
  }
}

class LHomeBodyWidget extends StatelessWidget {
  const LHomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pendingController = Get.put(LPendingRequestController());
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // Header container
        const LPrimaryHeaderContainer(),
        LPendingRequestList(pendingRequestController: pendingController, dark: dark),
        Obx(() {
          if (pendingController.hasReachedEnd.value) {
            return pendingController.circularIndicator();
          } else {
            return Container();
          }
        }),
      ],
    );
  }
}
