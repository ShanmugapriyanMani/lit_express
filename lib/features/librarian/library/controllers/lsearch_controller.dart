import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/snack_bar.dart';
import '../../../../connectivity/network_connectivity.dart';
import '../../../../data/service/api_service.dart';
import '../../../../utils/constants/text_strings.dart';
import '../models/pending_request_model.dart';

class LSearchController extends GetxController {
  static LSearchController get instance => Get.find();

  RxList<PendingRequest> searchedRequestList = <PendingRequest>[].obs;
  final searchTextEditingController = TextEditingController();
  RxString searchText = ''.obs;
  RxBool isInternetAvailable = true.obs;
  RxBool isBooksAvailable = false.obs;
  RxBool isLoading = false.obs;
  final networkConnectivity = Get.put(NetworkConnectivity());

  Future<void> getPendingRequestForSearch(String query) async {
    final isConnected = await networkConnectivity.isConnected();
    if (!isConnected) {
      isInternetAvailable.value = false;
      TSnackBar.warningSnackBar(title: 'No Internet Connection', message: TText.internetIssueMessage);
      return;
    }
    isLoading.value = true;
    final apiService = ApiService(baseUrl: TText.baseUrl);
    List<Map<String, dynamic>> requestList = await apiService.getRequestForSearchPendingBooks(query);
    isBooksAvailable.value = (requestList.isNotEmpty) ? true : false;
    if (isBooksAvailable.value == true) {
      searchedRequest(requestList);
    }
    isLoading.value = false;
  }

  Future<void> searchedRequest(List<Map<String, dynamic>> requestList) async {
    for (var requestData in requestList) {
      PendingRequest pendingRequest = PendingRequest.fromJson(requestData);
      searchedRequestList.add(pendingRequest);
    }
    update();
  }

}