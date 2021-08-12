import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/exceptions/app_exceptions.dart';
import 'package:project/core/utils/print_utils.dart';

import 'base_view_interface.dart';

class ApiResult<T> {
  void result(
      {Future<T?>? futureFunction,
      Function()? retryFunction,
      Function(T?)? response,
      required BuildContext context,
      String? message = "",
      String alertTitle = "Alert",
      bool showRetryDialog = false,
      bool showDialog = false,
      bool showToast = false,
      bool isBarrierDismissible = false}) async {
    try {
      Print.Error("Api Result Try inside");
      BaseView.handler(
          context: context,
          baseViewType: BaseViewType.OnShowLoadingDialogFullScreen,
          baseViewFields: BaseViewFields(isBarrierDismissible: false, message: "Please Wait"));
      T? result = await futureFunction;
      if (response != null) {
        response(result);
      }
      BaseView.handler(context: Get.context!, baseViewType: BaseViewType.OnHideDialog, baseViewFields: BaseViewFields());
    } catch (e) {
      Print.Error("Api Result Exception: $e");
      BaseView.handler(context: context, baseViewType: BaseViewType.OnHideDialog, baseViewFields: BaseViewFields());
      AppExceptions(
          context: context,
          exception: e,
          appExceptionsUIType: AppExceptionsUIType.SHOW_RETRY_DIALOG_FULL_SCREEN,
          isBarrierDismissible: isBarrierDismissible,
          message: message,
          alertTitle: alertTitle,
          retryFunction: retryFunction);
    }
  }
}
