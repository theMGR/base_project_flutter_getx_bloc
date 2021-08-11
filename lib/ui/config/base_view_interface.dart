
import 'package:flutter/material.dart';
import 'package:project/core/utils/ui_utils.dart';

abstract class BaseViewInterface {
  onRefresh({required BuildContext context});

  onRetry({required BuildContext context, required String message});

  addEvent(var event);
}



enum BaseViewType {
  OnHideDialog,
  OnScreenPop,
  OnShowAlertDialog,
  OnShowAlertDialogOkCancel,
  OnShowAlertDialogOkFunction,
  OnShowLoadingDialog,
  OnShowLoadingDialogFullScreen,
  ShowToast
}

class BaseViewFields {
  String alertTitle;
  String message;
  bool isBarrierDismissible;
  String okText;
  Function()? function;
  var result;
  Color? barrierColor;

  BaseViewFields({this.alertTitle = "Alert", this.message = "", this.isBarrierDismissible = false, this.okText = "Ok", this.function, this.result, this.barrierColor = Colors.white});
}


class BaseView {

  static handler({required BuildContext context, required BaseViewType baseViewType, required BaseViewFields baseViewFields}) {
    switch(baseViewType) {
      case BaseViewType.OnHideDialog:
        return UIUtils.onScreenPop(context: context, result: baseViewFields.result);
      case BaseViewType.OnScreenPop:
        return UIUtils.onScreenPop(context: context, result: baseViewFields.result);
      case BaseViewType.OnShowAlertDialog:
        UIUtils.showAlertDialog(context: context, alertTitle: baseViewFields.alertTitle, alertMessage: baseViewFields.message, isBarrierDismissible: baseViewFields.isBarrierDismissible);
        break;
      case BaseViewType.OnShowAlertDialogOkCancel:
        UIUtils.showAlertDialogOkCancel(
            context: context, alertTitle: baseViewFields.alertTitle, alertMessage: baseViewFields.message, function: baseViewFields.function, isBarrierDismissible: baseViewFields.isBarrierDismissible);
        break;
      case BaseViewType.OnShowAlertDialogOkFunction:
        UIUtils.showAlertDialogOkFunction(
            context: context, alertTitle: baseViewFields.alertTitle, alertMessage: baseViewFields.message, function: baseViewFields.function, okText: baseViewFields.okText, isBarrierDismissible: baseViewFields.isBarrierDismissible);
        break;
      case BaseViewType.OnShowLoadingDialog:
        UIUtils.showLoadingDialog(context: context, text: baseViewFields.message, isBarrierDismissible: baseViewFields.isBarrierDismissible);
        break;
      case BaseViewType.OnShowLoadingDialogFullScreen:
        UIUtils.showLoadingDialogFullScreen(context: context, text: baseViewFields.message, isBarrierDismissible: baseViewFields.isBarrierDismissible, barrierColor: baseViewFields.barrierColor);
        break;
      case BaseViewType.ShowToast:
        UIUtils.showToast(context: context, message: baseViewFields.message);
        break;

      default:
        UIUtils.showToast(context: context, message: baseViewFields.message);
        break;
    }
  }

}
