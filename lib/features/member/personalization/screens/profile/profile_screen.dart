import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/authentication/screens/onboarding/onboarding.dart';
import '../../../../../common/widgets/clip/circular_container.dart';
import '../../../../../common/widgets/clip/curved_edge_widget.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../authentication/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userModelController = Get.put(UserModelController());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TCurvedEdgeWidget(
            child: Container(
              color: TColors.primaryColor,
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(top: -50, right: -60, child: TCircularContainer(backgroundColor: TColors.white.withOpacity(0.1),)),
                    Positioned(top: 50, right: -80, child: TCircularContainer(backgroundColor: TColors.white.withOpacity(0.1),)),
                    Positioned(top: 10, left: 0, right: 0,
                      child: Column(
                        children: [
                          AppBar(
                            title: Align(alignment: Alignment.topLeft, child: Text("Account", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white),)),
                            automaticallyImplyLeading: false,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              children: [
                                Icon(Iconsax.profile_circle_copy, size: 50, color: TColors.grey,),

                                const SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${userModelController.firstName} ${userModelController.lastName}", style: Theme.of(context).textTheme.titleLarge,),
                                    Text(userModelController.userType)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text("Account Setting", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TColors.primaryColor),),
                  const Divider(),
                  ListTile(
                    title: Text('Member ID', style: Theme.of(context).textTheme.bodyLarge,),
                    subtitle: Text(userModelController.memberId, style: Theme.of(context).textTheme.bodyMedium),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('Library Member Code', style: Theme.of(context).textTheme.bodyLarge,),
                    subtitle: Text(userModelController.libraryMemberCode, style: Theme.of(context).textTheme.bodyMedium),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('Mobile No', style: Theme.of(context).textTheme.bodyLarge,),
                    subtitle: Text(userModelController.phone, style: Theme.of(context).textTheme.bodyMedium),
                    onTap: () {},
                  ),
                  const Divider(),
                ],
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15.0),
            child: SizedBox(
                width: double.maxFinite,
                child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: Get.overlayContext!,
                        barrierDismissible: false,
                        builder: (_) => const LogoutDialogBox(),
                      );

                      }, child: Text("Logout", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.primaryColor),))),
          )
        ],
      ),
    );
  }
}

class LogoutDialogBox extends StatelessWidget {
  const LogoutDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Are you want to logout?", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 100, child: OutlinedButton(onPressed: () {Navigator.pop(context);}, child: Text("No", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.primaryColor),))),
                SizedBox(width: 100, child: ElevatedButton(onPressed: () {Get.to(() => const OnBoardingScreen());}, child: Text("Yes", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.white))))
              ],
            )
          ],
        ),
      ),
    );
  }
}
