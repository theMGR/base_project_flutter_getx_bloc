import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project/core/utils/dates_utils.dart';
import 'package:project/core/utils/input_type_utils.dart';
import 'package:project/data/remote/model/module_lead/lead_dto.dart';
import 'package:project/presentation/ui/config/ui_config.dart';

import 'lead_approve_cancel_controller.dart';

class LeadApproveCancelPage extends StatefulWidget {
  static String leadApproveCancelLeadDTOKey = "leadApproveCancelLeadDTOKey";

  @override
  _LeadApproveCancelPageState createState() => _LeadApproveCancelPageState();
}

class _LeadApproveCancelPageState extends State<LeadApproveCancelPage> {
  final controller = Get.find<LeadApproveCancelController>();
  TextEditingController tecRemarks = TextEditingController();
  LeadDTO? leadDTO;

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      List<dynamic> arguments = Get.arguments as List<dynamic>;
      if (arguments.isNotEmpty) {
        leadDTO = arguments[0] as LeadDTO;
      }
    }
    return  Scaffold(appBar: AppBar(title: Text("")),body: _content(context));
  }

  _content(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.solidUser,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(leadDTO?.customerName ?? "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.users,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(leadDTO?.contactedVia ?? "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.solidAddressCard,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(leadDTO?.contactedDetails ?? "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.mobileAlt,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(leadDTO?.contactNo ?? "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.mapMarkedAlt,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(leadDTO?.place ?? "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.calendarCheck,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(DatesUtils.convertToHumanDate(leadDTO?.date) ?? "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),

            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.tshirt,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(leadDTO?.name ?? "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),

            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.rupeeSign,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(leadDTO?.price != null ? "${leadDTO?.price}" : "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),

            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.balanceScale,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(leadDTO?.quantity != null ? "${leadDTO?.quantity}" : "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),

            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                FontAwesomeIcons.infoCircle,
                size: 20,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(leadDTO?.description ?? "-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ]),
            SizedBox(height: 10),
            UIConfig.textFieldLabel(
                textEditingController: tecRemarks,
                title: "Remarks *",
                hintText: "Enter Remarks",
                maxLines: 5,
                length: 200,
                inputType: INPUT_TYPE.ALPHA_WITH_SPACE),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UIConfig.button(
                    width: 100,
                    context: context,
                    fillColor: UIConfig.buttonColor,
                    textColor: UIConfig.buttonTextColor,
                    title: "Approve",
                    onTap: () {
                      controller.createAcceptedLead(leadDTO);
                    }),
                UIConfig.button(
                    width: 100,
                    context: context,
                    fillColor: Colors.red[700],
                    textColor: UIConfig.buttonTextColor,
                    title: "Cancel",
                    onTap: () {
                      controller.createCancelledLead(tecRemarks.text, leadDTO);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<LeadApproveCancelController>();
    super.dispose();
  }


}
