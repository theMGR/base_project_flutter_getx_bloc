import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'get_xample_controller.dart';
import 'get_xample_get_builder_controller.dart';
import 'get_xample_getx_builder_controller.dart';

class GetXamplePage extends StatefulWidget {
  static String route = "/getXample";

  @override
  _GetXamplePageState createState() => _GetXamplePageState();
}

class _GetXamplePageState extends State<GetXamplePage> {
  final controller = Get.find<GetXampleController>();

  //GetXampleGetBuilderController getXampleGetBuilderController = Get.put(GetXampleGetBuilderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetXample")),
      body: _content(),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [_obx(), SizedBox(height: 10), _getBuilder(), SizedBox(height: 10), _getXBuilder()],
        ),
      ),
    );
  }

  Widget _obx() {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        color: Colors.black12,
        child: Column(children: [
          Text("Obx With Obs: Value: ${controller.countWithObx.value}"),
          SizedBox(height: 10),
          Text("Obx With Obs: Increment: ${controller.countWithObx}"),
          ElevatedButton(
              onPressed: () {
                controller.incrementWithObx();
              },
              child: Text("Obx [increment] With Obs", style: TextStyle(fontSize: 20))),
          SizedBox(height: 20),
          Text("Obx WithOut Obs: Increment: ${controller.countWithOutObx}"),
          ElevatedButton(
              onPressed: () {
                controller.incrementWithOutObx();
              },
              child: Text("Obx [increment] WithOut Obs", style: TextStyle(fontSize: 20))),
        ]),
      );
    });
  }

  Widget _getBuilder() {
    return GetBuilder<GetXampleGetBuilderController>(
        init: GetXampleGetBuilderController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            color: Colors.blue[100],
            child: Column(children: [
              Text("GetBuilder With Obs: Value: ${controller.countWithObx.value}"),
              SizedBox(height: 10),
              Text("GetBuilder With Obs: Increment: ${controller.countWithObx}"),
              ElevatedButton(
                  onPressed: () {
                    controller.incrementWithObx();
                  },
                  child: Text("GetBuilder [increment] With Obs", style: TextStyle(fontSize: 20))),
              SizedBox(height: 20),
              Text("GetBuilder WithOut Obs: Increment: ${controller.countWithOutObx}"),
              ElevatedButton(
                  onPressed: () {
                    controller.incrementWithOutObx();
                  },
                  child: Text("GetBuilder [increment] WithOut Obs", style: TextStyle(fontSize: 20))),
            ]),
          );
        });
  }

  Widget _getXBuilder() {
    return GetX<GetXampleGetXBuilderController>(
      init: GetXampleGetXBuilderController(),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          color: Colors.black12,
          child: Column(children: [
            Text("GetX With Obs: Value: ${controller.countWithObx.value}"),
            SizedBox(height: 10),
            Text("GetX With Obs: Increment: ${controller.countWithObx}"),
            ElevatedButton(
                onPressed: () {
                  controller.incrementWithObx();
                },
                child: Text("GetX [increment] With Obs", style: TextStyle(fontSize: 20))),
            SizedBox(height: 20),
            Text("GetX WithOut Obs: Increment: ${controller.countWithOutObx}"),
            ElevatedButton(
                onPressed: () {
                  controller.incrementWithOutObx();
                },
                child: Text("GetX [increment] WithOut Obx", style: TextStyle(fontSize: 20))),
          ]),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<GetXampleController>();
    super.dispose();
  }
}
