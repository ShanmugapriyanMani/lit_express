import 'package:get/get.dart';
import 'network_connectivity.dart';

class NetworkConnectivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkConnectivity>(() => NetworkConnectivity());
  }
}