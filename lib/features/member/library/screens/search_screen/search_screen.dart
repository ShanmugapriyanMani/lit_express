import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/member/library/controllers/search_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../common/style/spacing_style.dart';
import '../../../../../common/widgets/layout/listview_builder_layout.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../details/details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(TSearchController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primaryColor,
        title: Text("Library", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColors.white),),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: TColors.white,),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: TSpacingStyle.paddingWithSearchBarHeight,
            child: TextField(
              controller: searchController.searchTextEditingController,
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Search books',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: TColors.primaryColor),
              ),
              onChanged: (text) {
                if (text.length % 2 == 0) {
                  searchController.searchText.value = text;
                  searchController.getBooksForSearch(text);
                }
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (!searchController.isInternetAvailable.value) {
                return Column(
                  children: [
                    const SizedBox(height: 50),
                    Lottie.asset(
                        TImages.networkFailure,
                        width: 150,
                        height: 150
                    ),
                    Text('Failed to retrieve books', style: Theme.of(context).textTheme.bodyLarge)
                  ],
                );
              }

              if (searchController.searchText.value == '') {
                return Container();
              }

              if(searchController.isLoading.value) {
                return const Center(child: CircularProgressIndicator(color: TColors.primaryColor,));
              }

              if (!searchController.isBooksAvailable.value) {
                return Center(
                  child: Text(
                    'No Books Found!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              return TListViewBuilderLayout(
                itemCount: searchController.searchedBookList.length ,
                itemBuilder: (BuildContext ctx, index) {
                if (index == searchController.searchedBookList.length) {
                  return Container();
                } else {
                  return ListTile(
                    leading: SizedBox(
                      child: (searchController.searchedBookList[index].coverImage == '')
                          ? Image.asset(
                        TImages.booksPlaceholder,
                        width: TSizes.booksListWidth,
                        height: TSizes.booksListHeight,
                        fit: BoxFit.fill,
                      )
                          : Image.network(''),
                    ),
                    title: Text(
                      searchController.searchedBookList[index].bookName,
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
                            searchController.searchedBookList[index].authorName,
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
                            "Available: ${searchController.searchedBookList[index].stockAvailable}",
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
                      Get.to(() => DetailsScreen(bookIndex: index, searchController: searchController, dark: dark, bookListEnum: BookList.searchedBookList,));
                    },
                  );
                }
              },
              );
            })),
        ],
      ),
    );
  }
}
