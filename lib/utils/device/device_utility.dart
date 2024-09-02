
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TDeviceUtility {

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

}