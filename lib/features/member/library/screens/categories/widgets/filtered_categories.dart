import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../common/widgets/layout/listview_builder_layout.dart';
import '../../../../../../common/widgets/shimmer/vertical_books_shimmer.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helper/helper_functions.dart';
import '../../../controllers/fitered_books_controller.dart';
import '../../details/details_screen.dart';

class FilteredCategories extends StatelessWidget {
  const FilteredCategories({super.key, required});

  @override
  Widget build(BuildContext context) {
    final filteredBooksController = Get.put(TFilteredBooksController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primaryColor,
        title: Text("Filtered - Books", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white)),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: TColors.white,),
          onPressed: () {
            filteredBooksController.clearFilteredData();
            Get.back();
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Obx(() {
            if (!filteredBooksController.isInternetAvailable.value) {
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

            if (filteredBooksController.filteredBookList.isEmpty) {
              return const TVerticalBooksShimmer(itemCount: 10);
            }

            return Expanded(
              child: TListViewBuilderLayout(
                controller: filteredBooksController.scrollControllerForFilteredBooks,
                itemCount: filteredBooksController.filteredBookList.length,
                itemBuilder: (BuildContext ctx, index) {
                  if (index == filteredBooksController.filteredBookList.length) {
                    return Container();
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          child: (filteredBooksController.filteredBookList[index].coverImage == '')
                              ? Image.asset(
                            TImages.booksPlaceholder,
                            width: TSizes.booksListWidth,
                            height: TSizes.booksListHeight,
                            fit: BoxFit.fill,
                          )
                              : Image.network(filteredBooksController.filteredBookList[index].coverImage),
                        ),
                        title: Text(
                          filteredBooksController.filteredBookList[index].bookName,
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
                                filteredBooksController.filteredBookList[index].authorName,
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
                                "Available: ${filteredBooksController.filteredBookList[index].stockAvailable}",
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
                          Get.to(() => DetailsScreen(
                            bookIndex: index,
                            filteredBooksController: filteredBooksController,
                            dark: dark,
                            bookListEnum: BookList.filteredBookList,
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
            if (filteredBooksController.hasReachedEnd.value) {
              return filteredBooksController.circularIndicator();
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }
}

