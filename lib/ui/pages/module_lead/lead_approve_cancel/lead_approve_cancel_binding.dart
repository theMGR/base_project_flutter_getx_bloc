import 'package:get/get.dart';

import 'lead_approve_cancel_controller.dart';

class LeadApproveCancelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeadApproveCancelController());
  }
}
