import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/librarian/library/screens/ldetails/ldetails_screen.dart';
import 'package:lit_express/features/librarian/library/screens/lhome/lhome_screen.dart';
import 'package:lit_express/utils/constants/colors.dart';
import 'package:lit_express/utils/constants/enums.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../common/widgets/layout/listview_builder_layout.dart';
import '../../../../../../common/widgets/shimmer/vertical_books_shimmer.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helper/helper_functions.dart';
import '../../../controllers/lfiltered_pending_controller.dart';

class LFilteredPendingRequest extends StatelessWidget {
  const LFilteredPendingRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final filteredPendingController = Get.put(LFilteredPendingController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primaryColor,
        title: Text("Filtered - Pending Request", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white),),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: TColors.white),
          onPressed: () {
            filteredPendingController.clearFilteredData();
            Get.back();
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Obx(() {
            if (!filteredPendingController.isInternetAvailable.value) {
              return Column(
                children: [
                  const SizedBox(height: 150),
                  Lottie.asset(
                    TImages.networkFailure,
                    width: 150,
                    height: 150,
                  ),
                  Text('Failed to retrieve books', style: Theme.of(context).textTheme.bodyLarge),
                ],
              );
            }

            if (filteredPendingController.filteredPendingList.isEmpty) {
              return const TVerticalBooksShimmer(itemCount: 10);
            }

            return Expanded(
              child: TListViewBuilderLayout(
                controller: filteredPendingController.scrollControllerForFilteredPendingList,
                itemCount: filteredPendingController.filteredPendingList.length,
                itemBuilder: (BuildContext ctx, index) {
                  if (index == filteredPendingController.filteredPendingList.length) {
                    return Container();
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          child: (filteredPendingController.filteredPendingList[index].coverImage == '')
                              ? Image.asset(
                            TImages.booksPlaceholder,
                            width: TSizes.booksListWidth,
                            height: TSizes.booksListHeight,
                            fit: BoxFit.fill,
                          )
                              : Image.network(filteredPendingController.filteredPendingList[index].coverImage),
                        ),
                        title: Text(
                          "${filteredPendingController.filteredPendingList[index].firstName}  ${filteredPendingController.filteredPendingList[index].firstName}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .apply(color: dark ? TColors.light : Colors.black),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                filteredPendingController.filteredPendingList[index].bookName,
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
                                filteredPendingController.filteredPendingList[index].requestDate.substring(0, 10),
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
                        trailing: const Icon(Iconsax.arrow_right_copy, size: TSizes.arrowIconSize, color: TColors.thirdColor,),
                        onTap: () {
                          Get.to(() => LDetailsScreen(
                            bookIndex: index,
                            lFilteredPendingController: filteredPendingController,
                            dark: dark,
                            requestListEnum: PendingRequestList.filteredRequestList,
                          ));
                        },
                      ),
                    );
                  }
                },
              ),
            );
          }),
          Obx(() {
            if (filteredPendingController.hasReachedEnd.value) {
              return filteredPendingController.circularIndicator();
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }
}
