import 'package:get/get.dart';
import 'package:project/core/utils/d_mapper.dart';
import 'package:project/core/utils/dates_utils.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/core/utils/validation_utils.dart';
import 'package:project/data/local/repository/login_details_local_repository.dart';
import 'package:project/data/remote/model/login_details_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_contacted_via_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_create_edit_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_products_dto.dart';
import 'package:project/data/remote/repository/module_lead/module_lead_repository.dart';
import 'package:project/presentation/ui/config/base_view_interface.dart';

abstract class LeadCreateUpdateInterface {
  void getLeadContactedVia();

  void getLeadProducts();

  void baseViewHandler(BaseViewType baseViewType, BaseViewFields baseViewFields);

  void createLead(LeadCreateEditDTO? leadCreateEditDTO);

  void editCreatedLead(LeadCreateEditDTO? leadCreateEditDTO);
}

class LeadCreateUpdateController extends GetxController implements LeadCreateUpdateInterface {
  ModuleLeadRepository moduleLeadRepository = Get.find<ModuleLeadRepositoryImpl>();
  LoginDetailsLocalRepository? loginDetailsLocalRepository = Get.find<LoginDetailsLocalRepositoryImpl>();
  RxList<DMapper<LeadContactedViaDTO>> listLeadContactedViaDTODMapper = <DMapper<LeadContactedViaDTO>>[].obs;
  RxList<DMapper<LeadProductsDTO>> listLeadProductsDTODMapper = <DMapper<LeadProductsDTO>>[].obs;

  LoginDetailsDTO? loginDetailsDTO;

  @override
  void onInit() async {
    if (loginDetailsLocalRepository != null) {
      loginDetailsDTO = await loginDetailsLocalRepository?.getLoginDetailsFromLocal();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    getLeadContactedVia();
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
  void getLeadContactedVia() async {
    try {
      baseViewHandler(BaseViewType.OnShowLoadingDialogFullScreen, BaseViewFields(isBarrierDismissible: false, message: "Please Wait"));
      List<LeadContactedViaDTO>? listLeadContactedVia = await moduleLeadRepository.getContactedViaDetails();

      if (listLeadContactedVia != null) {
        for (LeadContactedViaDTO leadContactedViaDTO in listLeadContactedVia) {
          if (leadContactedViaDTO.name != null && leadContactedViaDTO.id != null) {
            listLeadContactedViaDTODMapper.add(DMapper<LeadContactedViaDTO>(
                text: leadContactedViaDTO.name!, idString: leadContactedViaDTO.name!, id: leadContactedViaDTO.id!, object: leadContactedViaDTO));
          }
        }
      }

      getLeadProducts();
    } catch (e) {
      Print("LeadCreateUpdateController: getLeadContactedVia: exception : $e");
      baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
      baseViewHandler(
          BaseViewType.OnShowAlertDialogOkFunction,
          BaseViewFields(
              message: "Something went wrong, Please try again later.",
              isBarrierDismissible: false,
              function: () {
                baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
              }));
    }
  }

  @override
  void getLeadProducts() async {
    try {
      List<LeadProductsDTO>? listLeadProducts = await moduleLeadRepository.getProducts();
      if (listLeadProducts != null) {
        for (LeadProductsDTO leadProductsDTO in listLeadProducts) {
          if (leadProductsDTO.name != null && leadProductsDTO.productId != null) {
            listLeadProductsDTODMapper.add(DMapper<LeadProductsDTO>(
                text: leadProductsDTO.name!, idString: leadProductsDTO.name!, id: leadProductsDTO.productId!, object: leadProductsDTO));
          }
        }
      }

      baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());

      update();
    } catch (e) {
      Print("LeadCreateUpdateController: getLeadProducts: exception : $e");
      baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
      baseViewHandler(
          BaseViewType.OnShowAlertDialogOkFunction,
          BaseViewFields(
              message: "Something went wrong, Please try again later.",
              isBarrierDismissible: false,
              function: () {
                baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
              }));
    }
  }

  @override
  void createLead(LeadCreateEditDTO? leadCreateEditDTO) async {
    if (loginDetailsDTO != null &&
        leadCreateEditDTO != null &&
        leadCreateEditDTO.customerName != null &&
        leadCreateEditDTO.contactedVia != null &&
        leadCreateEditDTO.contactedDetails != null &&
        leadCreateEditDTO.contactNo != null &&
        leadCreateEditDTO.place != null &&
        leadCreateEditDTO.productId != null &&
        leadCreateEditDTO.productName != null &&
        leadCreateEditDTO.price != null &&
        leadCreateEditDTO.quantity != null &&
        leadCreateEditDTO.description != null) {
      leadCreateEditDTO.createdBy = loginDetailsDTO?.userId != null ? "${loginDetailsDTO?.userId}" : null;
      leadCreateEditDTO.createdDate = DatesUtils.convertToServerDate(DateTime.now().toString());

      try {
        baseViewHandler(BaseViewType.OnShowLoadingDialogFullScreen, BaseViewFields(isBarrierDismissible: false, message: "Please Wait"));
        String? response = await moduleLeadRepository.createLead(leadCreateEditDTO);
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
        Print("LeadCreateUpdateController: createLead: Exception: $e");
        baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
        baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Something went wrong, Please try again later."));
      }
    } else {
      baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Kindly check all fields are filled or not !"));
    }
  }

  @override
  void editCreatedLead(LeadCreateEditDTO? leadCreateEditDTO) async {
    if (loginDetailsDTO != null &&
        leadCreateEditDTO != null &&
        leadCreateEditDTO.customerName != null &&
        leadCreateEditDTO.contactedVia != null &&
        leadCreateEditDTO.productId != null &&
        leadCreateEditDTO.productName != null &&
        leadCreateEditDTO.contactedDetails != null &&
        leadCreateEditDTO.contactNo != null &&
        leadCreateEditDTO.price != null &&
        leadCreateEditDTO.quantity != null &&
        leadCreateEditDTO.place != null &&
        leadCreateEditDTO.description != null) {
      leadCreateEditDTO.updatedBy = loginDetailsDTO?.userId != null ? "${loginDetailsDTO?.userId}" : null;
      leadCreateEditDTO.updatedDate = DatesUtils.convertToServerDate(DateTime.now().toString());

      try {
        baseViewHandler(BaseViewType.OnShowLoadingDialogFullScreen, BaseViewFields(isBarrierDismissible: false, message: "Please Wait"));
        String? response = await moduleLeadRepository.editCreatedLead(leadCreateEditDTO);
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
        Print("LeadCreateUpdateController: editCreatedLead: Exception: $e");
        baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
        baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Something went wrong, Please try again later."));
      }
    } else {
      baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Kindly check all fields are filled or not !"));
    }
  }
}
