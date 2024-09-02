import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/common/widgets/layout/listview_builder_layout.dart';
import 'package:lit_express/features/member/library/screens/categories/widgets/filtered_categories.dart';
import 'package:lit_express/utils/constants/sizes.dart';
import 'package:lit_express/utils/helper/helper_functions.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../controllers/book_list_controller.dart';
import '../../controllers/categories_controller.dart';
import '../../controllers/fitered_books_controller.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesController = Get.put(TCategoriesController());
    final filteredBooksController = Get.put(TFilteredBooksController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primaryColor,
        title: Text("Filter - Sort", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColors.white),),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: TColors.white,),
          onPressed: () {
            filteredBooksController.clearFilteredData();
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Obx(() => Positioned(
            top: TSizes.zero,
            left: TSizes.zero,
            right: THelperFunctions.screenWidth() * 0.6,
            bottom: TSizes.zero,
            child: Drawer(
              backgroundColor: dark ? TColors.dark : TColors.light,
              elevation: 1,
              shape: const BeveledRectangleBorder(),
              child: ListView(
                padding: EdgeInsets.zero,
                children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        title: (categoriesController.filterIndex.value == 0) ? const Text('Categories', style: TextStyle(color: TColors.primaryColor, fontWeight: FontWeight.bold),) : const Text('Categories'),
                        onTap: () {
                          categoriesController.changeFilter(0);
                        },
                      ),
                      ListTile(
                        title: (categoriesController.filterIndex.value == 1) ? const Text('Languages', style: TextStyle(color: TColors.primaryColor, fontWeight: FontWeight.bold),) : const Text('Languages'),
                        onTap: () {
                          categoriesController.changeFilter(1);
                        },
                      ),
                      ListTile(
                        title: (categoriesController.filterIndex.value == 2) ? const Text('Authors', style: TextStyle(color: TColors.primaryColor, fontWeight: FontWeight.bold),) : const Text('Authors'),
                        onTap: () {
                          categoriesController.changeFilter(2);
                        },
                      ),
                      const ListTile(),
                    ]
                ).toList(),
              ),
            ),
          ),),

          Obx(() {
            if (categoriesController.isLoading.value) {
              return Positioned(top: TSizes.zero,
                  right: TSizes.zero,
                  bottom: TSizes.zero,
                  left: THelperFunctions.screenWidth() * 0.4,
                  child: const Center(child: CircularProgressIndicator(color: TColors.primaryColor,)));
            }
            return Positioned(
              top: TSizes.zero,
              right: TSizes.zero,
              bottom: TSizes.zero,
              left: THelperFunctions.screenWidth() * 0.4,
              child: TListViewBuilderLayout(
                itemCount: categoriesController.lengthOfCategories(categoriesController.filterIndex.value),
                itemBuilder: (_, index) {
                  String displayText = '';
                  int actualIndex = categoriesController.filterIndex.value;
                  if(actualIndex == 0) {
                    displayText = categoriesController.tempCategory[index]['category_name'] ?? "";
                  } else if (actualIndex == 1) {
                    displayText = categoriesController.tempLanguage[index]['language_name'] ?? "";
                  } else if (actualIndex == 2){
                    displayText = categoriesController.tempAuthor[index]['author_name'] ?? "";
                  } else {
                    displayText = '';
                  }
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
                    ),

                    child: Obx(() {
                      if(actualIndex == 0) {
                        (categoriesController.isSelectedCategoryIndex.value == index) ? Text(displayText, style: const TextStyle(color: TColors.textPrimaryColor),) : Text(displayText);
                        (categoriesController.isSelectedCategoryIndex.value == index) ? const Icon(Icons.check, color: TColors.textPrimaryColor,) : const Icon(Icons.check);
                      } else if (actualIndex == 1) {
                        (categoriesController.isSelectedLanguageIndex.value == index) ? Text(displayText, style: const TextStyle(color: TColors.textPrimaryColor),) : Text(displayText);
                        (categoriesController.isSelectedLanguageIndex.value == index) ? const Icon(Icons.check, color: TColors.textPrimaryColor,) : const Icon(Icons.check);
                      } else {
                        (categoriesController.isSelectedAuthorIndex.value == index) ? Text(displayText, style: const TextStyle(color: TColors.textPrimaryColor),) : Text(displayText);
                        (categoriesController.isSelectedAuthorIndex.value == index) ? const Icon(Icons.check, color: TColors.textPrimaryColor,) : const Icon(Icons.check);
                      }

                      return ListTile(
                        title: categoriesController.listTitle(actualIndex, index, displayText),
                        leading: categoriesController.listTitleIcon(actualIndex, index),
                        onTap: () {
                          if(actualIndex == 0) {
                            categoriesController.isSelectedCategoryIndex.value = index;
                            categoriesController.selectedCategory.value = categoriesController.tempCategory[index]["category_name"];
                            categoriesController.selectedCategoryId.value = categoriesController.tempCategory[index]["category_id"];
                          } else if (actualIndex == 1) {
                            categoriesController.isSelectedLanguageIndex.value = index;
                            categoriesController.selectedLanguage.value = categoriesController.tempLanguage[index]["language_name"];
                            categoriesController.selectedLanguageId.value = categoriesController.tempLanguage[index]["language_id"];
                          } else {
                            categoriesController.isSelectedAuthorIndex.value = index;
                            categoriesController.selectedAuthor.value = categoriesController.tempAuthor[index]["author_name"];
                            categoriesController.selectedAuthorId.value = categoriesController.tempAuthor[index]["author_id"];
                          }

                        },
                      );
                    }),
                  );
                },
              ),
            );
          }),

          Positioned(
              top:THelperFunctions.screenHeight() * 0.8,
              left: TSizes.zero,
              right: TSizes.zero,
              bottom: TSizes.zero,
              child: Container(
                color: dark ? TColors.dark : TColors.light,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: THelperFunctions.screenWidth() * 0.32,
                      child: OutlinedButton(
                        onPressed: () {
                          filteredBooksController.filteredBookList.clear();
                          filteredBooksController.clearFilteredData();
                        },
                        child: Text('Clear', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TColors.primaryColor)),
                      ),
                    ),
                    SizedBox(
                      width: THelperFunctions.screenWidth() * 0.32,
                      child: ElevatedButton(
                        onPressed: () {
                          filteredBooksController.filteredBookList.clear();
                          filteredBooksController.fetchFilteredBooks(categoriesController.selectedCategoryId.value, categoriesController.selectedLanguageId.value, categoriesController.selectedAuthorId.value);
                          Get.to(() => const FilteredCategories());
                        },
                        child: Text('Apply', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TColors.white)),
                      ),
                    ),
                  ],
                ),
              )
          ),

        ],
      ),
    );
  }
}
