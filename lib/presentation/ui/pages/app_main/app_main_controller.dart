import 'dart:ui';

import 'package:get/get.dart';
import 'package:project/data/local/repository/locale_repository.dart';
import 'package:project/data/local/repository/login_details_local_repository.dart';
import 'package:project/data/remote/model/login_details_dto.dart';
import 'package:project/presentation/ui/config/route_config.dart';

import 'app_main_state.dart';

class AppMainController extends GetxController {
  final state = AppMainState();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    String? languageCode = await Get.find<LocaleRepositoryImpl>().getLanguageCodeFromLocal();
    Get.updateLocale(languageCode == null ? Locale("en"): Locale(languageCode));

    LoginDetailsLocalRepository? loginDetailsLocalRepository = Get.find<LoginDetailsLocalRepositoryImpl>();
    LoginDetailsDTO? loginDetailsDTO = await loginDetailsLocalRepository.getLoginDetailsFromLocal();

    if(loginDetailsDTO != null) {
      Get.offAllNamed(RouteConfig.login);
    } else {
      Get.offAllNamed(RouteConfig.splash);
    }


    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
