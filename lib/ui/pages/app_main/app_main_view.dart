import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_main_controller.dart';
import 'app_main_state.dart';

class AppMainPage extends StatefulWidget {
  @override
  _AppMainPageState createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  final controller = Get.find<AppMainController>();
  final AppMainState state = Get.find<AppMainController>().state;

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white);
  }

  @override
  void dispose() {
    Get.delete<AppMainController>();
    super.dispose();
  }
}
