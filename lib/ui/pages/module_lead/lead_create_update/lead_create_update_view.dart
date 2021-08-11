import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/utils/d_mapper.dart';
import 'package:project/core/utils/input_type_utils.dart';
import 'package:project/core/utils/validation_utils.dart';
import 'package:project/data/remote/model/module_lead/lead_contacted_via_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_create_edit_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_products_dto.dart';
import 'package:project/ui/config/drop_down_view.dart';
import 'package:project/ui/config/ui_config.dart';

import 'lead_create_update_controller.dart';

class LeadCreateUpdatePage extends StatefulWidget {
  @override
  _LeadCreateUpdatePageState createState() => _LeadCreateUpdatePageState();
}

class _LeadCreateUpdatePageState extends State<LeadCreateUpdatePage> {
  final controller = Get.find<LeadCreateUpdateController>();
  final TextEditingController tecCustomerName = TextEditingController();
  final TextEditingController tecContactedDetails = TextEditingController();
  final TextEditingController tecContactNumber = TextEditingController();
  final TextEditingController tecPlace = TextEditingController();
  final TextEditingController tecPrice = TextEditingController();
  final TextEditingController tecQuantity = TextEditingController();
  final TextEditingController tecDescription = TextEditingController();
  bool isFromEdit = false;
  LeadCreateEditDTO? leadCreateEditDTO;

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      List<dynamic> arguments = Get.arguments as List<dynamic>;
      if (arguments.isNotEmpty) {
        leadCreateEditDTO = arguments[0] as LeadCreateEditDTO;
        if (leadCreateEditDTO != null) {
          isFromEdit = true;
        }
      }
    } else {
      leadCreateEditDTO = LeadCreateEditDTO();
    }

    return Scaffold(appBar: AppBar(title: Text(isFromEdit ? "Edit Lead" : "Create Lead")), body: _obxContent(context));
  }

  void updateUI() {
    tecCustomerName.text = leadCreateEditDTO?.customerName ?? "";
    tecContactedDetails.text = leadCreateEditDTO?.contactedDetails ?? "";
    tecContactNumber.text = leadCreateEditDTO?.contactNo ?? "";
    tecPlace.text = leadCreateEditDTO?.place ?? "";
    tecPrice.text = leadCreateEditDTO?.price != null ? "${leadCreateEditDTO?.price}" : "";
    tecQuantity.text = leadCreateEditDTO?.quantity != null ? "${leadCreateEditDTO?.quantity}" : "";
    tecDescription.text = leadCreateEditDTO?.description ?? "";
  }

  void updateValues() {
    leadCreateEditDTO?.customerName = tecCustomerName.text;
    leadCreateEditDTO?.contactedDetails = tecContactedDetails.text;
    leadCreateEditDTO?.contactNo = tecContactNumber.text;
    leadCreateEditDTO?.place = tecPlace.text;
    leadCreateEditDTO?.price = !ValidationUtils.isEmpty(tecPrice.text) ? double.tryParse(tecPrice.text) : 0;
    leadCreateEditDTO?.quantity = !ValidationUtils.isEmpty(tecQuantity.text) ? int.tryParse(tecQuantity.text) : 0;
    leadCreateEditDTO?.description = tecDescription.text;
  }

  Widget _obxContent(BuildContext context) {
    return Obx(() {
      if (controller.listLeadProductsDTODMapper.length > 0 && controller.listLeadContactedViaDTODMapper.length > 0) {
        updateUI();
        return _content(context);
      } else {
        return Container();
      }
    });
  }

  Widget _content(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
        UIConfig.textFieldLabel(
            isEditable: isFromEdit ? false : true,
            textEditingController: tecCustomerName,
            title: "Customer Name",
            hintText: "Enter Customer Name",
            inputType: INPUT_TYPE.ALPHA_WITH_SPACE),
        SizedBox(height: 10),
        DropDownView<LeadContactedViaDTO>(
            dropViewSelectionIdType: DropViewSelectionIdType.SELECTION_BASED_ON_ID_STRING,
            dropViewSelectionType: DropViewSelectionType.SELECTION_BASED_ON_ID,
            selectedIdString: leadCreateEditDTO?.contactedVia ?? "",
            enable: isFromEdit ? false : true,
            title: "Contacted Via",
            hint: "Choose Contacted Via",
            items: controller.listLeadContactedViaDTODMapper.value,
            onItemSelected: (DMapper<LeadContactedViaDTO?>? mapper) {
              if (mapper != null && mapper.object != null && mapper.object?.name != null) {
                leadCreateEditDTO?.contactedVia = mapper.object?.name;
              }
            }),
        SizedBox(height: 10),
        UIConfig.textFieldLabel(
            isEditable: isFromEdit ? false : true,
            textEditingController: tecContactedDetails,
            title: "Contacted Details",
            hintText: "Enter Contacted Details",
            inputType: INPUT_TYPE.ALPHA_WITH_SPACE),
        SizedBox(height: 10),
        UIConfig.textFieldLabel(
            textEditingController: tecContactNumber, title: "Contact Number", hintText: "Enter Contact Number", inputType: INPUT_TYPE.NUMERIC_INT, length: 10),
        SizedBox(height: 10),
        UIConfig.textFieldLabel(textEditingController: tecPlace, title: "Place", hintText: "Enter Place", inputType: INPUT_TYPE.ALPHA_WITH_SPACE),
        SizedBox(height: 10),
        DropDownView<LeadProductsDTO>(
            dropViewSelectionIdType: DropViewSelectionIdType.SELECTION_BASED_ON_ID_STRING,
            dropViewSelectionType: DropViewSelectionType.SELECTION_BASED_ON_ID,
            selectedIdString: leadCreateEditDTO?.productName ?? "",
            enable: isFromEdit ? false : true,
            title: "Products",
            hint: "Choose Products",
            items: controller.listLeadProductsDTODMapper.value,
            onItemSelected: (DMapper<LeadProductsDTO?>? mapper) {
              if (mapper != null && mapper.object != null && mapper.object?.name != null && mapper.object?.productId != null) {
                leadCreateEditDTO?.productId = mapper.object?.productId;
                leadCreateEditDTO?.productName = mapper.object?.name;
              }
            }),
        SizedBox(height: 10),
        UIConfig.textFieldLabel(textEditingController: tecPrice, title: "Price", hintText: "Enter Price", inputType: INPUT_TYPE.NUMERIC_FLOAT),
        SizedBox(height: 10),
        UIConfig.textFieldLabel(textEditingController: tecQuantity, title: "Quantity", hintText: "Enter Quantity", inputType: INPUT_TYPE.NUMERIC_INT),
        SizedBox(height: 10),
        UIConfig.textFieldLabel(
            textEditingController: tecDescription, title: "Description", hintText: "Enter Description", inputType: INPUT_TYPE.ALPHA_WITH_SPACE),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: UIConfig.button(
              width: 100,
              context: context,
              fillColor: UIConfig.buttonColor,
              textColor: UIConfig.buttonTextColor,
              title: "Submit",
              onTap: () {
                updateValues();
                if (isFromEdit) {
                  controller.editCreatedLead(leadCreateEditDTO);
                } else {
                  controller.createLead(leadCreateEditDTO);
                }
              }),
        )
      ])),
    );
  }

  @override
  void dispose() {
    Get.delete<LeadCreateUpdateController>();
    super.dispose();
  }
}
