import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lit_express/features/librarian/library/controllers/lfilter_controller.dart';
import 'package:lit_express/features/librarian/library/models/pending_request_model.dart';

import '../../../../common/widgets/snack_bar.dart';
import '../../../../connectivity/network_connectivity.dart';
import '../../../../data/service/api_service.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';

class LFilteredPendingController extends GetxController {
  static LFilteredPendingController get instance => Get.find();

  Rx<int> pageNo = 0.obs;
  RxBool hasReachedEnd = false.obs;
  RxBool isPendingAvailable = false.obs;
  RxBool isInternetAvailable = true.obs;

  RxList<PendingRequest> filteredPendingList = <PendingRequest>[].obs;

  ScrollController scrollControllerForFilteredPendingList = ScrollController();
  final networkConnectivity = Get.put(NetworkConnectivity());
  final filterController = Get.put(LFilterController());

  Future<void> fetchFilteredPendingList(String sortBy, String sortOrder) async {
    scrollControllerForFilteredPendingList.addListener(onScrollForFilter);
    final isConnected = await networkConnectivity.isConnected();
    if (!isConnected) {
      isInternetAvailable.value = false;
      TSnackBar.warningSnackBar(title: 'No Internet Connection', message: TText.internetIssueMessage);
      return;
    }
    pageNo.value++;
    final apiService = ApiService(baseUrl: TText.baseUrl);
    final pendingList = await apiService.requestForFilterRequest(sortBy, sortOrder, pageNo.value);
    isPendingAvailable.value = (pendingList.isNotEmpty) ? true : false;
    if (isPendingAvailable.value == true) {
      addFilteredPendingList(pendingList);
    }
  }

  void addFilteredPendingList(List<Map<String, dynamic>> requestList) {
    for (var requestData in requestList) {
      PendingRequest pendingRequest = PendingRequest.fromJson(requestData);
      filteredPendingList.add(pendingRequest);
    }
    update();
  }

  void onScrollForFilter() {
    if (scrollControllerForFilteredPendingList.position.pixels == scrollControllerForFilteredPendingList.position.maxScrollExtent) {
      hasReachedEnd.value = true;
      isPendingAvailable.value = true;
    } else {
      hasReachedEnd.value = false;
      isPendingAvailable.value = false;
    }
  }

  Widget circularIndicator() {
    if (hasReachedEnd.value && isPendingAvailable.value) {
      hasReachedEnd.value = false;
      fetchFilteredPendingList(filterController.selectedSort.value, filterController.selectedOrder.value);
      return const CircularProgressIndicator(color: TColors.primaryColor,);
    } else {
      return Container();
    }
  }

  void clearFilteredData() {
    filterController.isSelectedOrderIndex.value = -1.obs;
    filterController.isSelectedSortIndex.value = -1.obs;
    filterController.selectedOrder.value = '';
    filterController.selectedSort.value = '';
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollControllerForFilteredPendingList.dispose();
  }

}