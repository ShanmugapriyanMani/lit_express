import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../../../common/widgets/layout/listview_builder_layout.dart';
import '../../../../../common/widgets/loader/animation_loader.dart';
import '../../../../../common/widgets/shimmer/vertical_books_shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../controllers/lapproved_controller.dart';

class LApprovedScreen extends StatelessWidget {
  const LApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final approvedController = Get.put(LApprovedController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColors.white),
          "Approved History",
        ),
        backgroundColor: TColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Expanded(
            child: Obx(() {
              if (!approvedController.isInternetAvailable.value) {
                return Column(
                  children: [
                    const SizedBox(height: 150),
                    Lottie.asset(
                      TImages.networkFailure,
                      width: 150,
                      height: 150,
                    ),
                    Text('Failed to retrieve Approval', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                );
              }

              if (approvedController.approvedList.isEmpty && !approvedController.isApprovedListAvailable.value) {
                return const TVerticalBooksShimmer(itemCount: 10);
              }

              if (approvedController.approvedList.isEmpty && approvedController.isApprovedListAvailable.value) {
                return const TAnimationLoaderWidget(text: 'No approved list', animation: TImages.noBooksPlaceholder,);
              }

              return TListViewBuilderLayout(
                controller: approvedController.scrollControllerForApprovedList,
                itemCount: approvedController.approvedList.length,
                itemBuilder: (BuildContext ctx, index) {
                  if (index == approvedController.approvedList.length) {
                    return Container();
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          child: (approvedController.approvedList[index].coverImage == '')
                              ? Image.asset(
                            TImages.booksPlaceholder,
                            width: TSizes.booksListWidth,
                            height: TSizes.booksListHeight,
                            fit: BoxFit.fill,
                          )
                              : Image.network(approvedController.approvedList[index].coverImage),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "${approvedController.approvedList[index].firstName}  ${approvedController.approvedList[index].firstName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(color: dark ? TColors.light : Colors.black),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "status: ${approvedController.approvedList[index].processedMemberStatus}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: dark ? TColors.light : Colors.black),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Approved by: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(color: dark ? TColors.light : Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    '${approvedController.approvedList[index].processedMemberFirstname} ${approvedController.approvedList[index].processedMemberLastname}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(color: dark ? TColors.light : Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Approved date: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(color: dark ? TColors.light : Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    approvedController.approvedList[index].requestDate.substring(0, 10),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(color: dark ? TColors.light : Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            }),
          ),
          Obx(() {
            if (approvedController.hasReachedEnd.value) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                approvedController.circularIndicator();
              });
              return const CircularProgressIndicator(color: TColors.primaryColor);
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }
}
