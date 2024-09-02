import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/utils/constants/enums.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/style/spacing_style.dart';
import '../../../../../common/widgets/layout/listview_builder_layout.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../controllers/lsearch_controller.dart';
import '../ldetails/ldetails_screen.dart';

class LSearchScreen extends StatelessWidget {
  const LSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lSearchController = Get.put(LSearchController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Pending Request", style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: Column(
        children: [
          Padding(
            padding: TSpacingStyle.paddingWithSearchBarHeight,
            child: TextField(
              controller: lSearchController.searchTextEditingController,
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: TColors.primaryColor),
              ),
              onChanged: (text) {
                if (text.length % 2 == 0) {
                  lSearchController.searchText.value = text;
                  lSearchController.getPendingRequestForSearch(text);
                }
              },
            ),
          ),
          Expanded(
              child: Obx(() {
                if (!lSearchController.isInternetAvailable.value) {
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

                if (lSearchController.searchText.value == '') {
                  return Container();
                }

                if(lSearchController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: TColors.primaryColor,));
                }

                if (!lSearchController.isBooksAvailable.value) {
                  return Center(
                    child: Text(
                      'No Request Found!',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }

                return TListViewBuilderLayout(
                  itemCount: lSearchController.searchedRequestList.length ,
                  itemBuilder: (BuildContext ctx, index) {
                    if (index == lSearchController.searchedRequestList.length) {
                      return Container();
                    } else {
                      return ListTile(
                        leading: SizedBox(
                          child: (lSearchController.searchedRequestList[index].coverImage == '')
                              ? Image.asset(
                            TImages.booksPlaceholder,
                            width: TSizes.booksListWidth,
                            height: TSizes.booksListHeight,
                            fit: BoxFit.fill,
                          )
                              : Image.network(''),
                        ),
                        title: Text(
                          "${lSearchController.searchedRequestList[index].firstName}  ${lSearchController.searchedRequestList[index].firstName}",
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
                                lSearchController.searchedRequestList[index].bookName,
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
                                lSearchController.searchedRequestList[index].requestDate.substring(0, 10),
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
                          Get.to(() => LDetailsScreen(bookIndex: index, lSearchController: lSearchController, dark: dark, requestListEnum: PendingRequestList.searchedRequestList,));
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