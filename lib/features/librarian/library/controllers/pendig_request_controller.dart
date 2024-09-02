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
import '../../../../utils/helper/helper_functions.dart';
import '../../../member/personalization/screens/profile/profile_screen.dart';
import '../models/pending_request_model.dart';
import '../screens/lapproved/lapproved_screen.dart';
import '../screens/lhome/lhome_screen.dart';

class LPendingRequestController extends GetxController with GetTickerProviderStateMixin {
  static LPendingRequestController get instance => Get.find<LPendingRequestController>();

  RxList<PendingRequest> pendingRequestList = <PendingRequest>[].obs;

  Rx<int> pageNo = 0.obs;
  RxBool hasReachedEnd = false.obs;
  RxBool isPendingAvailable = false.obs;
  RxBool isInternetAvailable = true.obs;
  Rx<int> selectedIndex = 1.obs;
  final networkConnectivity = Get.put(NetworkConnectivity());
  ScrollController scrollController = ScrollController();

  RxList<Widget> tabItems = [
    const LApprovedScreen(),
    const LHomeBodyWidget(),
    const ProfileScreen()
  ].obs;

  @override
  void onInit() {
    fetchRequestedBooks();
    scrollController.addListener(onScroll);
    super.onInit();
  }

  Future<void> fetchRequestedBooks() async {
    final isConnected = await networkConnectivity.isConnected();
    if (!isConnected) {
      isInternetAvailable.value = false;
      TSnackBar.warningSnackBar(
          title: 'No Internet Connection',
          message: TText.internetIssueMessage
      );
      return;
    }

    pageNo.value++;
    final apiService = ApiService(baseUrl: TText.baseUrl);
    final requestList = await apiService.getPendingRequest(pageNo.value);
    isPendingAvailable.value = true;
    if (requestList.isNotEmpty) {
      assignAllRequest(requestList);
    } else {
      pageNo.value--;
    }

  }

  void onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      hasReachedEnd.value = true;
      isPendingAvailable.value = true;
    } else {
      hasReachedEnd.value = false;
      isPendingAvailable.value = false;
    }
  }


  Future<void> assignAllRequest(List<Map<String, dynamic>> requestList) async {
    for (var requestData in requestList) {
      PendingRequest pendingRequest = PendingRequest.fromJson(requestData);
      pendingRequestList.add(pendingRequest);
    }
    update();
  }

  Widget circularIndicator() {
    if (hasReachedEnd.value && isPendingAvailable.value) {
      hasReachedEnd.value = false;
      isPendingAvailable.value = true;
      fetchRequestedBooks();
      return const CircularProgressIndicator(color: TColors.primaryColor,);
    } else {
      return Container();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

}

