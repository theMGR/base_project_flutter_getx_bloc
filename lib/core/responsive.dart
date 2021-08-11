import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Responsive {
  static const double mobileSize = 100;
  static const double tabSize = 720;
  static const double webSize = 1300;

  static Widget? getWidget({Widget? mobile, Widget? tab, Widget? web}) {
    if (isWeb() && web != null) {
      return web;
    } else if (isTab() && tab != null) {
      return tab;
    } else {
      return mobile;
    }
  }

  static bool isMobile() {
    Size screenSize = Get.mediaQuery.size;
    double screenWidth = screenSize.width;
    return screenWidth >= mobileSize && screenWidth < tabSize;
  }

  static bool isTab() {
    Size screenSize = Get.mediaQuery.size;
    double screenWidth = screenSize.width;
    return screenWidth >= tabSize && screenWidth < webSize;
  }

  static bool isWeb() {
    Size screenSize = Get.mediaQuery.size;
    double screenWidth = screenSize.width;
    return screenWidth >= webSize;
  }
}
