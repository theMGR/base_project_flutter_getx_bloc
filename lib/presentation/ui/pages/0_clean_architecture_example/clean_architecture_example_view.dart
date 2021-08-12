import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'clean_architecture_example_controller.dart';

class CleanArchitectureExamplePage extends StatefulWidget {
  static String route = "/cleanArchitectureExamplePage";

  @override
  _CleanArchitectureExamplePageState createState() => _CleanArchitectureExamplePageState();
}

class _CleanArchitectureExamplePageState extends State<CleanArchitectureExamplePage> {
  final controller = Get.find<CleanArchitectureExampleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Clean Architecture Example")), body: _content());
  }

  Widget _content() {
    return Obx(() {
      return Container(margin: EdgeInsets.all(10),child: Text("Total Count: ${controller.sampleQuotableRX.value.totalCount} \n\n"
          "Total Pages: ${controller.sampleQuotableRX.value.totalPages}\n\n"
          "Count: ${controller.sampleQuotableRX.value.count}\n\n"
          "Page: ${controller.sampleQuotableRX.value.page}"));
    });
  }

  @override
  void dispose() {
    Get.delete<CleanArchitectureExampleController>();
    super.dispose();
  }
}
