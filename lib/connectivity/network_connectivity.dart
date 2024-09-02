import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lit_express/common/widgets/snack_bar.dart';

import '../utils/constants/text_strings.dart';

class NetworkConnectivity extends GetxController {
  static NetworkConnectivity get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;


  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Update connection status
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus.value = result;
    if (connectionStatus.value == ConnectivityResult.none) {
      // warning snack bar
      TSnackBar.warningSnackBar(title: 'No Internet Connection', message: TText.internetIssueMessage);
    } else {
      TSnackBar.hideSnackBar();
    }

  }

  /// Check internet connection status
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      connectionStatus.value = result;
      return result != ConnectivityResult.none;
    } on PlatformException {
      return false;
    }
  }


  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }

}