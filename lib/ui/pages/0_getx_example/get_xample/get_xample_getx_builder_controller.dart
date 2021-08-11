import 'package:get/get.dart';

class GetXampleGetXBuilderController extends GetxController {
  var countWithObx = 0.obs;
  int countWithOutObx = 0;

  void incrementWithObx() {
    ++countWithObx;
  }

  void incrementWithOutObx() {
    ++countWithOutObx;
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
