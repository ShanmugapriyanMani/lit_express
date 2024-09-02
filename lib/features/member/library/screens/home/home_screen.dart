import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/member/library/screens/home/widgets/all_book_list.dart';
import 'package:lit_express/utils/constants/sizes.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../personalization/screens/profile/profile_screen.dart';
import '../../controllers/book_list_controller.dart';
import '../../controllers/checkout_list_controller.dart';
import '../checkout/checkout_screen.dart';
import 'widgets/primary_header_container.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booksController = Get.put(TBookListController());
    final checkoutController = Get.put(TCheckoutBooksController());
    final dark = THelperFunctions.isDarkMode(context);

    List<Widget> tabItems = [
      const CheckOutScreen(),
      HomeBodyWidget(booksController: booksController, dark: dark),
      const ProfileScreen()
    ];
    return Scaffold(
      body: Obx(() => tabItems[booksController.selectedIndex.value],),
      bottomNavigationBar: Obx(() => FlashyTabBar(
        backgroundColor: dark ? TColors.midBlack : TColors.white,
        selectedIndex: booksController.selectedIndex.value,
        showElevation: true,
        onItemSelected: (index) {
          booksController.selectedIndex.value = index;
        },
        items: [
          FlashyTabBarItem(
            icon: Obx(() => badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 0),
              showBadge: checkoutController.isSlideToRequested.value,
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
              child: const Icon(Iconsax.book, size: TSizes.bottomNavIconSize, color: TColors.primaryColor,),
            ),),
            title: const Text('Card', style: TextStyle(color: TColors.primaryColor,),),
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
      ),)
    );
  }
}

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
    required this.booksController,
    required this.dark,
  });

  final TBookListController booksController;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header container
        const TPrimaryHeaderContainer(),
        AllBookList(booksController: booksController, dark: dark),

        Obx(() {
          if (booksController.hasReachedEnd.value) {
            return booksController.circularIndicator();
          } else {
            return Container();
          }
        }),
      ],
    );
  }
}






