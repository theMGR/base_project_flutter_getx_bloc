import 'package:get/get.dart';
import 'package:project/data/remote/model/sample_dto.dart';
import 'package:project/data/remote/repository/sample_repository.dart';

class AppMainState {
  SampleQuotableDTO? sampleQuotableDTO;
  SampleRepository? sampleRepository;
  AppMainState() {
    init();
  }

  void init() async {
    sampleRepository = Get.find<SampleRepositoryImpl>();
  }
}
