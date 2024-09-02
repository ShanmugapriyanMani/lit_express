import 'package:get/get.dart';
import 'package:lit_express/features/librarian/library/controllers/pendig_request_controller.dart';

import '../../../../common/widgets/snack_bar.dart';
import '../../../../connectivity/network_connectivity.dart';
import '../../../../data/service/api_service.dart';
import '../../../../utils/constants/text_strings.dart';

class LDetailsController extends GetxController {
  static LDetailsController get instance => Get.find();

  final networkConnectivity = Get.put(NetworkConnectivity());
  RxBool isInternetAvailable = true.obs;
  RxBool isSlideToApprove = false.obs;

  Future<bool> approveRequestedBook(String requestId) async {
    final isConnected = await networkConnectivity.isConnected();
    if (!isConnected) {
      isInternetAvailable.value = false;
      TSnackBar.warningSnackBar(title: 'No Internet Connection', message: TText.internetIssueMessage);
      return false;
    }

    final apiService = ApiService(baseUrl: TText.baseUrl);
    return await apiService.requestForPendingApproval(requestId);

  }

  Future<void> removePendingRequest(String requestId) async {
    final pendingController = Get.put(LPendingRequestController());
    for (var requestData in pendingController.pendingRequestList) {
      if (requestData.requestId == requestId) {
        // pendingController.pendingRequestList.removeAt(pendingController.pendingRequestList.indexOf(requestData.requestId));
        // int index  = pendingController.pendingRequestList.indexOf(requestData.requestId);
        // pendingController.pendingRequestList.removeAt(index).obs;
      }
    }
    update();
    }


}