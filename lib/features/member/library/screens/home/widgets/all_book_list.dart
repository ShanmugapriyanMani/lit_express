import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/member/library/screens/details/details_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../common/widgets/layout/listview_builder_layout.dart';
import '../../../../../../common/widgets/loader/screen_loader.dart';
import '../../../../../../common/widgets/shimmer/vertical_books_shimmer.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../controllers/book_list_controller.dart';

class AllBookList extends StatelessWidget {
  const AllBookList({
    super.key,
    required this.booksController,
    required this.dark,
  });

  final TBookListController booksController;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!booksController.isInternetAvailable.value) {
        return Column(
          children: [
            const SizedBox(height: 150),
            Lottie.asset(
                TImages.networkFailure,
                width: 150,
                height: 150
            ),
            Text('Failed to retrieve books', style: Theme.of(context).textTheme.bodyLarge)
          ],
        );
      }
      if (booksController.bookList.isEmpty) {
        return const Expanded(child: TVerticalBooksShimmer(itemCount: 10));
      }
      if (booksController.bookList.isNotEmpty) {
        return Expanded(
          child: TListViewBuilderLayout(
            controller: booksController.scrollController,
            itemCount: booksController.bookList.length,
            itemBuilder: (BuildContext ctx, index) {
              if (index == booksController.bookList.length) {
                return Container();
              } else {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
                  ),
                  child: ListTile(
                    leading: SizedBox(
                      child: (booksController.bookList[index].coverImage == '')
                          ? Image.asset(
                        TImages.booksPlaceholder,
                        width: TSizes.booksListWidth,
                        height: TSizes.booksListHeight,
                        fit: BoxFit.fill,
                      )
                          : Image.network(''),
                    ),
                    title: Text(
                      booksController.bookList[index].bookName,
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
                            booksController.bookList[index].authorName,
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
                            "Available: ${booksController.bookList[index].stockAvailable}",
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
                      Get.to(() => DetailsScreen(bookIndex: index, booksController: booksController, dark: dark, bookListEnum: BookList.allBookList));
                    },
                  ),
                );
              }
            },
          ),
        );
      }
      return TFullScreenLoader.bookLoader();
    });
  }
}


