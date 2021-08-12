import 'package:get/get.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/remote/model/module_lead/lead_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_list_dto.dart';
import 'package:project/data/remote/repository/module_lead/module_lead_repository.dart';
import 'package:project/presentation/ui/config/base_view_interface.dart';

abstract class LeadListInterface {
  void getLeads();

  void baseViewHandler(BaseViewType baseViewType, BaseViewFields baseViewFields);

  void getCreatedLeadById(int id, Function(LeadDTO?)? function);
}

class LeadListController extends GetxController implements LeadListInterface {
  ModuleLeadRepository moduleLeadRepository = Get.find<ModuleLeadRepositoryImpl>();
  RxList<LeadListDTO> listLeadDTO = <LeadListDTO>[].obs;

  @override
  void onReady() {
    // TODO: implement onReady
    //getLeads();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void getLeads() async {
    try {
      //baseViewHandler(BaseViewType.OnShowLoadingDialog, BaseViewFields(isBarrierDismissible: false, message: "Please Wait"));

      List<LeadListDTO>? listLead = await moduleLeadRepository.getLeads();

      if (listLead != null) {
        listLeadDTO.assignAll(listLead);
        //update();
      }
    } catch (e) {
      Print("LeadListController: getLeads: exception : $e");
      //baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
      baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Something went wrong, Please try again later."));
    }
  }

  @override
  void baseViewHandler(BaseViewType baseViewType, BaseViewFields baseViewFields) {
    BaseView.handler(context: Get.context!, baseViewType: baseViewType, baseViewFields: baseViewFields);
  }

  @override
  void getCreatedLeadById(int? id, Function(LeadDTO? leadDTO)? function) async {
    try {
      baseViewHandler(BaseViewType.OnShowLoadingDialogFullScreen, BaseViewFields(isBarrierDismissible: false, message: "Please Wait"));

      LeadDTO? leadDTO = await moduleLeadRepository.getCreatedLeadById(id);
      baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());

      if (id != null && function != null) {
        function(leadDTO);
      }
    } catch (e) {
      Print("LeadListController: getCreatedLeadById: exception : $e");
      baseViewHandler(BaseViewType.OnHideDialog, BaseViewFields());
      baseViewHandler(BaseViewType.OnShowAlertDialog, BaseViewFields(message: "Something went wrong, Please try again later."));
    }
  }
}
