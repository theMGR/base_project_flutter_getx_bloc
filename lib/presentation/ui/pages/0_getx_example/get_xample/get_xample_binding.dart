import 'package:get/get.dart';

import 'get_xample_controller.dart';

class GetXampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetXampleController());
  }
}
