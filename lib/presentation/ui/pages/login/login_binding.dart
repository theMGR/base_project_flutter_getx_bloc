import 'package:get/get.dart';
import 'package:project/data/remote/repository/sample_quotable_repository_impl.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
