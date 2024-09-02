import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loader/animation_loader.dart';
import '../../../../common/widgets/snack_bar.dart';
import '../../../../connectivity/network_connectivity.dart';
import '../../../../data/service/api_service.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../models/pending_request_model.dart';
import 'ldetails_request_controller.dart';

class LApprovedController extends GetxController {
  static LApprovedController get instance => Get.find();

  RxList<PendingRequest> approvedList = <PendingRequest>[].obs;

  Rx<int> pageNo = 0.obs;
  RxBool hasReachedEnd = false.obs;
  RxBool isApprovedListAvailable = false.obs;
  RxBool isInternetAvailable = true.obs;

  ScrollController scrollControllerForApprovedList = ScrollController();
  final networkConnectivity = Get.put(NetworkConnectivity());
  final lDetailsController = Get.put(LDetailsController());

  @override
  void onInit() {
    fetchApprovedList();
    scrollControllerForApprovedList.addListener(onScrollForFilter);
    super.onInit();
  }

  Future<void> fetchApprovedList() async {
    final isConnected = await networkConnectivity.isConnected();
    if (!isConnected) {
      isInternetAvailable.value = false;
      TSnackBar.warningSnackBar(title: 'No Internet Connection', message: TText.internetIssueMessage);
      return;
    }

    pageNo.value++;
    final apiService = ApiService(baseUrl: TText.baseUrl);
    final approvedData = await apiService.requestForApprovedList(pageNo.value);
    isApprovedListAvailable.value = true;
    if (approvedData.isNotEmpty) {
      addApprovedList(approvedData);
    } else {
      pageNo.value--;
    }

  }

  void addApprovedList(List<Map<String, dynamic>> approvalList) {
    for (var approvedData in approvalList) {
      PendingRequest pendingRequestApproved = PendingRequest.fromJson(approvedData);
      approvedList.add(pendingRequestApproved);
    }
    update();
  }

  void onScrollForFilter() {
    if (scrollControllerForApprovedList.position.pixels == scrollControllerForApprovedList.position.maxScrollExtent) {
      hasReachedEnd.value = true;
      isApprovedListAvailable.value = true;
    } else {
      hasReachedEnd.value = false;
      isApprovedListAvailable.value = false;
    }
  }

  Widget circularIndicator() {
    if (hasReachedEnd.value && isApprovedListAvailable.value) {
      hasReachedEnd.value = false;
      lDetailsController.isSlideToApprove.value = true;
      fetchApprovedList();
      return const CircularProgressIndicator(color: TColors.primaryColor,);
    } else {
      return Container();
    }
  }

}
