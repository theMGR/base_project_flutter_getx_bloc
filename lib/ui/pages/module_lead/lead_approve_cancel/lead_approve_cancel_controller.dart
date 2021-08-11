import 'package:get/get.dart';
import 'package:project/core/utils/dates_utils.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/core/utils/validation_utils.dart';
import 'package:project/data/local/repository/login_details_local_repository.dart';
import 'package:project/data/remote/model/login_details_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_approve_cancel_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_dto.dart';
import 'package:project/data/remote/repository/module_lead/module_lead_repository.dart';
import 'package:project/ui/config/base_view_interface.dart';

abstract class LeadApproveCancelInterface {
  void baseViewHandler(BaseViewType baseViewType, BaseViewFields baseViewFields);

  void createAcceptedLead(LeadDTO? leadDTO);

  void createCancelledLead(String? remarks, LeadDTO? leadDTO);
}

class LeadApproveCancelController extends GetxController implements LeadApproveCancelInterface {
  ModuleLeadRepository moduleLeadRepository = Get.find<ModuleLeadRepositoryImpl>();
  LoginDetailsLocalRepository? loginDetailsLocalRepository = Get.find<LoginDetailsLocalRepositoryImpl>();
  LoginDetailsDTO? loginDetailsDTO;

  @override
  void onInit() async {
    if (loginDetailsLocalRepository != null) {
      loginDetailsDTO = await loginDetailsLocalRepository?.getLoginDetailsFromLocal();
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

  @override
  void baseViewHandler(BaseViewType baseViewType, BaseViewFields baseViewFields) {
    BaseView.handler(context: Get.context!, baseViewType: baseViewType, baseViewFields: baseViewFields);
  }

  @override
  void createAcceptedLead(LeadDTO? leadDTO) async {
    if (loginDetailsDTO != null && leadDTO != null && leadDTO.leadNo != null) {
      try {
        baseViewHandler(BaseViewType.OnShowLoadingDialogFullScreen, BaseViewFields(isBarrierDismissible: false, message: "Please Wait"));

        LeadApproveCancelDTO leadApproveCancelDTO = LeadApproveCancelDTO(
            leadId: leadDTO.leadNo,
            updatedBy: loginDetailsDTO?.userId != null ? "${loginDetailsDTO?.userId}" : null,
            updatedDate: DatesUtils.convertToServerDate(DateTime.now().toString()));

        String? response = await moduleLeadRepository.createAcceptedLead(leadApproveCancelDTO);
        baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());

        baseViewHandler(
            BaseViewType.OnShowAlertDialogOkFunction,
            BaseViewFields(
                message: !ValidationUtils.isEmpty(response) ? response : "Something went wrong, Please try again later.",
                isBarrierDismissible: false,
                function: () {
                  Get.back();
                  Get.back(result: true);
                }));
      } catch (e) {
        Print("LeadApproveCancelController: createAcceptedLead: Exception: $e");
        baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
        baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Something went wrong, Please try again later."));
      }
    } else {
      baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Something went wrong, Please try again later."));
    }
  }

  @override
  void createCancelledLead(String? remarks, LeadDTO? leadDTO) async {
    if (loginDetailsDTO != null && leadDTO != null && leadDTO.leadNo != null && remarks != null && !ValidationUtils.isEmpty(remarks)) {
      try {
        baseViewHandler(BaseViewType.OnShowLoadingDialogFullScreen, BaseViewFields(isBarrierDismissible: false, message: "Please Wait"));

        LeadApproveCancelDTO leadApproveCancelDTO = LeadApproveCancelDTO(
            leadId: leadDTO.leadNo,
            updatedBy: loginDetailsDTO?.userId != null ? "${loginDetailsDTO?.userId}" : null,
            updatedDate: DatesUtils.convertToServerDate(DateTime.now().toString()),
            reason: remarks);

        String? response = await moduleLeadRepository.createCancelledLead(leadApproveCancelDTO);
        baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());

        baseViewHandler(
            BaseViewType.OnShowAlertDialogOkFunction,
            BaseViewFields(
                message: !ValidationUtils.isEmpty(response) ? response : "Something went wrong, Please try again later.",
                isBarrierDismissible: false,
                function: () {
                  Get.back();
                  Get.back(result: true);
                }));
      } catch (e) {
        Print("LeadApproveCancelController: createCancelledLead: Exception: $e");
        baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
        baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Something went wrong, Please try again later."));
      }
    } else {
      baseViewHandler(BaseViewType.OnShowAlertDialog,
          BaseViewFields(message: remarks == null || ValidationUtils.isEmpty(remarks) ? "Kindly enter remarks !" : "Something went wrong, Please try again later."));
    }
  }
}
