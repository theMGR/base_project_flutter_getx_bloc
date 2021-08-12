import 'package:get/get.dart';

import 'lead_create_update_controller.dart';

class LeadCreateUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeadCreateUpdateController());
  }
}
