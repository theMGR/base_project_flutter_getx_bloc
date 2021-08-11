import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/ui/pages/home/widgets/home_drawer.dart';
import 'package:project/ui/pages/module_lead/lead_list/lead_list_view.dart';

import 'home_controller.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<HomeController>();
  final HomeState state = Get.find<HomeController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Enquiry")),
        drawer: SafeArea(child: Obx(() {
          return HomeDrawer.drawer(controller.loginDetailsDTO.value);
        })),
        body: LeadListPage());
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }
}
