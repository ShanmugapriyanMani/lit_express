import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../connectivity/network_connectivity.dart';
import '../../../../utils/constants/colors.dart';


class LFilterController extends GetxController {
  static LFilterController get instance => Get.find<LFilterController>();

  RxBool isFilterApply = false.obs;
  Rx<int> filterIndex = 0.obs;

  RxBool isInternetAvailable = true.obs;
  RxBool isRequestAvailable = false.obs;
  RxBool isLoading = false.obs;

  final networkConnectivity = Get.put(NetworkConnectivity());

  RxInt isSelectedSortIndex = RxInt(-1);
  RxInt isSelectedOrderIndex = RxInt(-1);

  RxString selectedSort = ''.obs;
  RxString selectedOrder = ''.obs;

  RxList<String> sortBy = <String>['Date', 'Member'].obs;
  RxList<String> orderBy = <String>['Ascending', 'Descending'].obs;

  @override
  void onInit() {
    filterIndex.value = 0;
    super.onInit();
  }


  Widget listTitle(int actualIndex, int index, String displayText) {
    if(actualIndex == 0) {
      return (isSelectedSortIndex.value == index) ? Text(displayText, style: const TextStyle(color: TColors.textPrimaryColor),) : Text(displayText);
    } else {
      return (isSelectedOrderIndex.value == index) ? Text(displayText, style: const TextStyle(color: TColors.textPrimaryColor),) : Text(displayText);
    }
  }

  Widget listTitleIcon(int actualIndex, int index) {
    if(actualIndex == 0) {
      return (isSelectedSortIndex.value == index) ? const Icon(Icons.check, color: TColors.textPrimaryColor,) : const Icon(Icons.check);
    } else {
      return (isSelectedOrderIndex.value == index) ? const Icon(Icons.check, color: TColors.textPrimaryColor,) : const Icon(Icons.check);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    isSelectedSortIndex.value = -1.obs;
    isSelectedOrderIndex.value = -1.obs;
    selectedSort.value = '';
    selectedOrder.value = '';

  }

}

