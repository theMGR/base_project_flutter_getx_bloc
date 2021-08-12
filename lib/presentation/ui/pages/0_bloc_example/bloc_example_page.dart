import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/core/utils/print_utils.dart';

import 'example_bloc/example_bloc.dart';

class BlocExamplePage extends StatefulWidget {

  static String route = "/blocExamplePage";

  const BlocExamplePage({Key? key}) : super(key: key);

  @override
  _BlocExamplePageState createState() => _BlocExamplePageState();
}

class _BlocExamplePageState extends State<BlocExamplePage> {
  var _currentEvent;
  int? count;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Bloc Example"),),
      body: BlocListener<ExampleBloc, ExampleState>(listener: (context, state) {
          if(state is IncrementState) {
            count = state.count;
            Print("Bloc Example: $count");
          }
      },
      child: BlocBuilder<ExampleBloc, ExampleState>(builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(children: [
            Text("Increment value: ${count != null ? count : 0}"),
            ElevatedButton(
                onPressed: () {
                  _addEvent(IncrementEvent());
                },
                child: Text("[increment]", style: TextStyle(fontSize: 20))),

          ]),
        );
      }),
      ),
    );
  }

  _addEvent(var event) {
    context.read<ExampleBloc>().add(_currentEvent = event);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    Get.find<ExampleBloc>().clear();
    super.dispose();
  }
}
