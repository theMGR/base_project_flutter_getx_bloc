import 'package:get/get.dart';
import 'package:project/domain/entities/sample_quotable.dart';
import 'package:project/domain/usecases/sample_quotable_usecase.dart';

class CleanArchitectureExampleController extends GetxController {
  SampleQuotableUseCase sampleQuotableUseCase = Get.find<SampleQuotableUseCase>();
  var sampleQuotableRX = SampleQuotable().obs;

  @override
  void onInit() async{
    SampleQuotable? sampleQuotable = await sampleQuotableUseCase.call(SampleQuotableParams(page: 1, limit: 1));
    if(sampleQuotable != null) {
      sampleQuotableRX.value = sampleQuotable;
    }
    super.onInit();
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
