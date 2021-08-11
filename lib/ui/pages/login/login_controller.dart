import 'package:get/get.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/core/utils/ui_utils.dart';
import 'package:project/data/local/repository/login_details_local_repository.dart';
import 'package:project/data/remote/model/login_details_dto.dart';
import 'package:project/data/remote/repository/module_lead/module_lead_repository.dart';
import 'package:project/ui/config/api_result.dart';
import 'package:project/ui/config/base_view_interface.dart';
import 'package:project/ui/config/route_config.dart';

import 'login_state.dart';

abstract class LoginInterface {
  void getUserByMobileNo(String mobileNo, String password);

  void baseViewHandler(BaseViewType baseViewType, BaseViewFields baseViewFields);
}

class LoginController extends GetxController implements LoginInterface {
  final state = LoginState();
  ModuleLeadRepository moduleLeadRepository = Get.find<ModuleLeadRepositoryImpl>();
  LoginDetailsLocalRepository loginDetailsLocalRepository = Get.find<LoginDetailsLocalRepositoryImpl>();

  @override
  void onInit() async {
    LoginDetailsLocalRepository? loginDetailsLocalRepository = Get.find<LoginDetailsLocalRepositoryImpl>();
    LoginDetailsDTO? loginDetailsDTO = await loginDetailsLocalRepository.getLoginDetailsFromLocal();

    if (loginDetailsDTO != null && loginDetailsDTO.mobileNo != null && loginDetailsDTO.password != null) {
      getUserByMobileNo(loginDetailsDTO.mobileNo, loginDetailsDTO.password);
    }
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void getUserByMobileNo(String? mobileNo, String? password) async {
/*    ApiResult<List<LoginDetailsDTO>?>().result(
        response: (List<LoginDetailsDTO>? response) {
          Print.Info("Response ${response![0].toRawJson()}");
        },
        context: Get.context!,
        futureFunction: moduleLeadRepository.getUserByMobileNo("9999999999"),
        showRetryDialog: true,
        retryFunction: () {
          UIUtils.onScreenPop(context: Get.context!);
          getUserByMobileNo(mobileNo, password);
        });*/
    if (mobileNo != null && mobileNo.trim().length > 0 && mobileNo.trim().length == 10 && password != null && password.trim().length > 0) {
      try {
        baseViewHandler(BaseViewType.OnShowLoadingDialogFullScreen, BaseViewFields(isBarrierDismissible: false, message: "Please Wait"));
        List<LoginDetailsDTO> loginDetails = await moduleLeadRepository.getUserByMobileNo(mobileNo);

        if (loginDetails.isNotEmpty) {
          if (loginDetails[0].mobileNo != null &&
              loginDetails[0].mobileNo?.toLowerCase().compareTo(mobileNo.toLowerCase()) == 0 &&
              loginDetails[0].password != null &&
              loginDetails[0].password?.compareTo(password) == 0) {
            bool? isSaved = await loginDetailsLocalRepository.saveLoginDetailsToLocal(loginDetailsDTO: loginDetails[0]);
            if (isSaved) {
              baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
              Get.offAllNamed(RouteConfig.home);
            } else {
              baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
              baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Something went wrong, Please try again later."));
            }
          } else {
            baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
            baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Invalid Mobile number [or] Password."));
          }
        } else {
          baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
          baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Invalid Mobile number [or] Password."));
        }
      } catch (e) {
        Print("LoginController: getUserByMobileNo: exception : $e");
        baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
        baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Something went wrong, Please try again later."));
      }
    } else {
      baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Kindly enter valid Mobile number [or] Password"));
    }
  }

  @override
  void baseViewHandler(BaseViewType baseViewType, BaseViewFields baseViewFields) {
    BaseView.handler(context: Get.context!, baseViewType: baseViewType, baseViewFields: baseViewFields);
  }
}
