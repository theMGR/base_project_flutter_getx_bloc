import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/presentation/ui/pages/0_bloc_example/example_bloc/example_bloc.dart';

class AppBlocContainer {


  static MultiBlocProvider multiBlocProvider({required Widget child}) {
    return MultiBlocProvider(child: child, providers: [
      BlocProvider<ExampleBloc>(
        create: (context) => Get.find<ExampleBloc>(),
      )
    ]);
  }

}