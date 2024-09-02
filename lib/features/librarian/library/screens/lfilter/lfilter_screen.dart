import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lit_express/features/librarian/library/controllers/lfiltered_pending_controller.dart';
import 'package:lit_express/features/librarian/library/screens/lfilter/widgets/lfiltered_pending_request.dart';

import '../../../../../common/widgets/layout/listview_builder_layout.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../controllers/lfilter_controller.dart';

class LFilterScreen extends StatelessWidget {
  const LFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(LFilterController());
    final filteredPendingController = Get.put(LFilteredPendingController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primaryColor,
        title: Text("Filter - Sort", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white)),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: TColors.white,),
          onPressed: () {
            filteredPendingController.clearFilteredData();
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Obx(() {
            return Positioned(
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
                        title: Text(
                          'Sort by',
                          style: filterController.filterIndex.value == 0
                              ? const TextStyle(color: TColors.primaryColor, fontWeight: FontWeight.bold)
                              : null,
                        ),
                        onTap: () {
                          filterController.filterIndex.value = 0;
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Order by',
                          style: filterController.filterIndex.value == 1
                              ? const TextStyle(color: TColors.primaryColor, fontWeight: FontWeight.bold)
                              : null,
                        ),
                        onTap: () {
                          filterController.filterIndex.value = 1;
                        },
                      ),
                      const ListTile(),
                    ],
                  ).toList(),
                ),
              ),
            );
          }),
          Positioned(
            top: TSizes.zero,
            right: TSizes.zero,
            bottom: TSizes.zero,
            left: THelperFunctions.screenWidth() * 0.4,
            child: Obx(() {
              final actualIndex = filterController.filterIndex.value;
              return TListViewBuilderLayout(
                itemCount: actualIndex == 0 ? filterController.sortBy.length : filterController.orderBy.length,
                itemBuilder: (_, index) {
                  String displayText = actualIndex == 0
                      ? filterController.sortBy[index]
                      : filterController.orderBy[index];

                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
                    ),
                    child: ListTile(
                      title: Obx(() => filterController.listTitle(actualIndex, index, displayText)),
                      leading: Obx(() => filterController.listTitleIcon(actualIndex, index)),
                      onTap: () {
                        if (actualIndex == 0) {
                          filterController.isSelectedSortIndex.value = index;
                          filterController.selectedSort.value = filterController.sortBy[index];
                        } else {
                          filterController.isSelectedOrderIndex.value = index;
                          filterController.selectedOrder.value = filterController.orderBy[index];
                        }
                      },
                    ),
                  );
                },
              );
            }),
          ),
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
                          filteredPendingController.filteredPendingList.clear();
                          filteredPendingController.clearFilteredData();
                        },
                        child: Text('Clear', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TColors.primaryColor),),
                      ),
                    ),
                    SizedBox(
                      width: THelperFunctions.screenWidth() * 0.32,
                      child: ElevatedButton(
                        onPressed: () {
                          filteredPendingController.filteredPendingList.clear();
                          filteredPendingController.fetchFilteredPendingList(filterController.selectedSort.value, filterController.selectedOrder.value);
                          Get.to(() => const LFilteredPendingRequest());
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
