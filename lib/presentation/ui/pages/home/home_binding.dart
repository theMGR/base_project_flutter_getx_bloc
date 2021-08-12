import 'package:get/get.dart';
import 'package:project/presentation/ui/pages/module_lead/lead_list/lead_list_controller.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => LeadListController());
  }
}
