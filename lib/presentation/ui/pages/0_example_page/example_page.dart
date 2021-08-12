import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/presentation/ui/pages/0_bloc_example/bloc_example_page.dart';
import 'package:project/presentation/ui/pages/0_getx_example/get_xample/get_xample_view.dart';

class ExamplePage extends StatelessWidget {
  static String route = "/examplePage";
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Examples"),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(GetXamplePage.route);
                },
                child: Text("GetX Example", style: TextStyle(fontSize: 20))),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(BlocExamplePage.route);
                },
                child: Text("Flutter Bloc Example", style: TextStyle(fontSize: 20))),
          ]),
        ),
      ),
    );
  }
}
