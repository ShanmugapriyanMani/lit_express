import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/librarian/library/controllers/pendig_request_controller.dart';
import 'package:lit_express/utils/constants/enums.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../common/widgets/layout/listview_builder_layout.dart';
import '../../../../../../common/widgets/loader/animation_loader.dart';
import '../../../../../../common/widgets/loader/screen_loader.dart';
import '../../../../../../common/widgets/shimmer/vertical_books_shimmer.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../ldetails/ldetails_screen.dart';

class LPendingRequestList extends StatelessWidget {
  const LPendingRequestList({super.key, required this.pendingRequestController, required this.dark});

  final LPendingRequestController pendingRequestController;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(() {
          if (!pendingRequestController.isInternetAvailable.value) {
            return Column(
              children: [
                const SizedBox(height: 150),
                Lottie.asset(
                    TImages.networkFailure,
                    width: 150,
                    height: 150
                ),
                Text('Failed to retrieve request', style: Theme.of(context).textTheme.bodyLarge)
              ],
            );
          }
          if (pendingRequestController.pendingRequestList.isEmpty && !pendingRequestController.isPendingAvailable.value) {
            return const TVerticalBooksShimmer(itemCount: 10);
          }

          if (pendingRequestController.pendingRequestList.isEmpty && pendingRequestController.isPendingAvailable.value) {
            return const TAnimationLoaderWidget(text: 'No pending request', animation: TImages.noBooksPlaceholder,);
          }
          return TListViewBuilderLayout(
              controller: pendingRequestController.scrollController,
              itemCount: pendingRequestController.pendingRequestList.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
                  ),
                  child: ListTile(
                    leading: SizedBox(
                      child: (pendingRequestController.pendingRequestList[index].coverImage == '')
                          ? Image.asset(
                        TImages.booksPlaceholder,
                        width: TSizes.booksListWidth,
                        height: TSizes.booksListHeight,
                        fit: BoxFit.fill,
                      )
                          : Image.network(''),
                    ),
                    title: Text(
                      "${pendingRequestController.pendingRequestList[index].firstName}  ${pendingRequestController.pendingRequestList[index].firstName}",
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
                            pendingRequestController.pendingRequestList[index].bookName,
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
                            pendingRequestController.pendingRequestList[index].requestDate.substring(0, 10),
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
                      Get.to(() => LDetailsScreen(bookIndex: index, pendingRequestController: pendingRequestController, dark: dark, requestListEnum: PendingRequestList.allRequestList,));
                    },
                  ),
                );
              }
          );

        })
    );
  }
}
