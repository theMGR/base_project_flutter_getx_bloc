import 'package:get/get.dart';

import 'clean_architecture_example_controller.dart';

class CleanArchitectureExampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CleanArchitectureExampleController());
  }
}
