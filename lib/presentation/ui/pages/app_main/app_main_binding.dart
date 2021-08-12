import 'package:get/get.dart';


import 'app_main_controller.dart';

class AppMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppMainController());
  }
}
