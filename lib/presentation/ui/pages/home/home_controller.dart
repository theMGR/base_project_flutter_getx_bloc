import 'package:get/get.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/local/repository/login_details_local_repository.dart';
import 'package:project/data/remote/model/login_details_dto.dart';


import '../../../../app_initializer.dart';
import 'home_state.dart';

class HomeController extends GetxController {
  final state = HomeState();
  Rx<LoginDetailsDTO> loginDetailsDTO = LoginDetailsDTO().obs;

  @override
  void onInit() async{
    AppInitializer.initFirebaseLocalNotificationWorkManagerPermission(onFcmToken: (String? fcmToken) {
      Print.Info("MyApp FCM Token: $fcmToken");
    });

    LoginDetailsLocalRepository? loginDetailsLocalRepository = Get.find<LoginDetailsLocalRepositoryImpl>();
    LoginDetailsDTO? loginDetailsDTOLocal = await loginDetailsLocalRepository.getLoginDetailsFromLocal();

    if(loginDetailsDTOLocal != null) {
      loginDetailsDTO.value = loginDetailsDTOLocal;
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
