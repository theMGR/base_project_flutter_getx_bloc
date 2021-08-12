import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/core/utils/ui_utils.dart';
import 'package:project/core/utils/validation_utils.dart';
import 'package:url_launcher/url_launcher.dart';

enum CommunicationType { DIALLER, SMS, EMAIL }

class CommunicationUtils {
  static void launchDialerOrMessageApp(
      {required BuildContext context, required CommunicationType communicationType, required String contactID, bool isAlertAsDialog = true}) async {
    String alertMessage = "Something went wrong.";
    String alertType = "app";
    String launchUri;

    if (communicationType == CommunicationType.DIALLER) {
      launchUri = "tel:$contactID";
      alertType = "dialler";
    } else if (communicationType == CommunicationType.SMS) {
      launchUri = "sms:$contactID";
      alertType = "message app";
    } else if (communicationType == CommunicationType.EMAIL) {
      launchUri = "mailto:$contactID";
      alertType = "email";
    } else {
      launchUri = "";
    }
    if (!ValidationUtils.isEmpty(launchUri) && !ValidationUtils.isEmpty(contactID)) {
      try {
        await launch(launchUri);
      } catch (e) {
        Print.Reference("${communicationType.toString()} : Exception :->" + e.toString());
        alertMessage = "Could not open $alertType, Something went wrong.";
        if (isAlertAsDialog) {
          UIUtils.showAlertDialog(context: context, alertTitle: "Alert", alertMessage: alertMessage);
        } else {
          UIUtils.showToast(context: context, message: alertMessage);
        }
      }
    } else {
      alertMessage = "Contact information not available.";
      if (isAlertAsDialog) {
        UIUtils.showAlertDialog(context: context, alertTitle: "Alert", alertMessage: alertMessage);
      } else {
        UIUtils.showToast(context: context, message: alertMessage);
      }
    }
  }

}
