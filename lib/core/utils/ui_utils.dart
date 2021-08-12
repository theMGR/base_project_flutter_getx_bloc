import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/core/utils/validation_utils.dart';
import 'package:project/core/widgets/retry_widget/retry_widget.dart';
import 'package:project/presentation/res/business_constants/ui_constants.dart';
import 'package:project/presentation/res/constants/constant_color.dart';

import 'dates_utils.dart';
import 'input_type_utils.dart';

class UIUtils {
  static Widget datePickerWithText(
      {TextEditingController? textEditingController,
      String title = "",
      String hintText = "Select date",
      String selectedDate = "",
      bool firstDateIsCurrentTime = false,
      bool lastDateIsCurrentTime = false,
      Function(String?)? onYYYYMMDD,
      Function(String?)? onServerDate}) {
    initializeDateFormatting(Intl.systemLocale, null);

    hintText = ValidationUtils.isEmpty(title) ? "Select date" : "Select $title";

    DateTime _selectedDateTime = DateTime.now();
    String _selectedDate = "";

    try {
      _selectedDateTime = ValidationUtils.isEmpty(selectedDate) ? DateTime.now() : DateTime.parse(selectedDate);
      _selectedDate = DateFormat(UIConstants.DATE_FORMAT_YYYY_MM_DD).format(_selectedDateTime);
    } catch (e) {
      _selectedDateTime = DateTime.now();
      _selectedDate = "";
    }

    return StatefulBuilder(
      builder: (context, setState) {
        setState(() {
          if (textEditingController != null) {
            if (_selectedDate.trim().length > 0 && selectedDate.trim().length > 0) {
              textEditingController.text = _selectedDate;
            }
          }
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            InkWell(
              onTap: () async {
                DateTime? pickedDateTime = await showDatePicker(
                  context: context,
                  initialDate: _selectedDateTime,
                  firstDate: firstDateIsCurrentTime ? DateTime.now() : DateTime(1950),
                  lastDate: lastDateIsCurrentTime ? DateTime.now() : DateTime(3000),
                  helpText: title,
                  cancelText: 'Cancel',
                  confirmText: 'Ok',
                );

                if (pickedDateTime != null && pickedDateTime != _selectedDateTime) {
                  setState(() {
                    _selectedDateTime = pickedDateTime;
                    _selectedDate = DateFormat(UIConstants.DATE_FORMAT_YYYY_MM_DD).format(_selectedDateTime);

                    if (textEditingController != null) {
                      textEditingController.text = _selectedDate;
                      Print.Reference("Date -> ${textEditingController.text}");
                    }

                    if (onYYYYMMDD != null) {
                      onYYYYMMDD(DatesUtils.formatDate(_selectedDate, UIConstants.DATE_FORMAT_YYYY_MM_DD));
                    }

                    if (onServerDate != null) {
                      onServerDate(DatesUtils.formatDate(_selectedDate, UIConstants.DATE_FORMAT_SERVICE));
                    }
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.only(left: 3, right: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: ColorConstant.grey_1,
                      width: 1,
                    )),
                child: TextField(
                  controller: textEditingController != null ? textEditingController : TextEditingController(),
                  keyboardType: TextInputType.text,
                  enabled: false,
                  decoration: InputDecoration(
                    suffixIcon: Icon(FontAwesomeIcons.calendarAlt),
                    //filled: true,
                    //fillColor: Colors.amberAccent,
                    //contentPadding: EdgeInsets.only(5),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: hintText,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  static void showToast({required BuildContext? context, required String message}) {
    if(context != null) {
      FToast fToast = FToast();
      fToast.init(context);

      Widget toast = Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Colors.grey[500]!, width: 0.2),
          color: Colors.grey[100],
        ),
        child: Text(message, style: TextStyle(color: Colors.black)),
      );

      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );
    }
  }

  static Widget labelWithText(
      {TextEditingController? textEditingController,
      String title = "",
      String hintText = "",
      bool isEditable = true,
      INPUT_TYPE inputType = INPUT_TYPE.ALPHA_NUMERIC_SPECIAL_CHAR,
      int length = 100,
      int maxLines = 1,
      bool isCounterTextEnabled = false,
      Color fillColor = Colors.white,
      bool isColorFilled = false,
      Function(String)? onTextChanged,
      double titleSize = 18,
      double textSize = 16,
      TextStyle? titleTextStyle,
      TextStyle? textStyle,
      TextStyle? hintTextStyle,
      Color titleColor = Colors.black45,
      Color textColor = Colors.black,
      Color hintTextColor = Colors.grey,
      double borderRadius = 5,
      Color borderColor = ColorConstant.grey_1,
      Widget? prefixIcon,
      Widget? suffixIcon,
      bool obscureText = false,
      String obscuringCharacter = "."}) {
    hintText = ValidationUtils.isEmpty(hintText)
        ? ValidationUtils.isEmpty(title)
            ? "Enter Text"
            : "Enter $title"
        : hintText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !ValidationUtils.isEmpty(title)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleTextStyle == null ? TextStyle(color: titleColor, fontSize: titleSize, fontWeight: FontWeight.bold) : titleTextStyle),
                  SizedBox(height: 5),
                ],
              )
            : Container(),
        TextField(
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
            return isCounterTextEnabled
                ? Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    alignment: Alignment.centerRight,
                    child: Text(currentLength.toString() + "/" + maxLength.toString()))
                : Container();
          },
          maxLength: length,
          maxLines: maxLines,
          onChanged: (text) {
            if (onTextChanged != null) {
              onTextChanged(text);
            }
          },
          controller: textEditingController != null ? textEditingController : TextEditingController(),
          keyboardType: InputTypeUtils.getTextInputType(inputType),
          inputFormatters: InputTypeUtils.getTextInputFormatter(inputType),
          enabled: isEditable,
          style: textStyle == null ? TextStyle(color: textColor, fontSize: textSize) : textStyle,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            hintText: hintText,
            hintStyle: hintTextStyle == null ? TextStyle(color: hintTextColor) : hintTextStyle,
            fillColor: fillColor,
            filled: isColorFilled,
            prefixIcon: prefixIcon == null ? SizedBox() : prefixIcon,
            suffixIcon: suffixIcon == null ? SizedBox() : suffixIcon,
            prefixIconConstraints: BoxConstraints(
              minHeight: prefixIcon == null ? 5 : 32,
              minWidth: prefixIcon == null ? 5 : 32,
            ),
            suffixIconConstraints: BoxConstraints(
              minHeight: suffixIcon == null ? 5 : 32,
              minWidth: suffixIcon == null ? 5 : 32,
            ),
          ),
        )
      ],
    );
  }

  static Widget gradientBar({required double height}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.blue_1, ColorConstant.blue_2],
/*            begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp*/
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.blue_3, ColorConstant.blue_4],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.yellow_1, ColorConstant.yellow_2],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.yellow_3, ColorConstant.yellow_4],
              ),
            ),
          ),
        )
      ],
    );
  }

  static void showAlertDialog({required BuildContext? context, required String alertTitle, required String alertMessage, bool isBarrierDismissible = true}) {
    if(context != null) {
      // Create button
      Widget okButton = ElevatedButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // Create AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(alertTitle),
        content: SingleChildScrollView(child: Text(alertMessage)),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        barrierDismissible: isBarrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  static void showAlertDialogOkFunction(
      {required BuildContext? context,
      required String alertTitle,
      required String alertMessage,
      required Function()? function,
      String okText = "OK",
      bool isBarrierDismissible = true}) {

    if(context != null) {
      // Create button
      Widget okButton = ElevatedButton(
        child: Text(okText),
        onPressed: function,
      );

      // Create AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(alertTitle),
        content: SingleChildScrollView(child: Text(alertMessage)),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        barrierDismissible: isBarrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  static void showAlertDialogOkCancel(
      {required BuildContext context,
      required String alertTitle,
      required String alertMessage,
      required Function()? function,
      bool isBarrierDismissible = true}) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: function,
    );

    Widget cancelButton = ElevatedButton(
      child: Text("CANCEL"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(child: Text(alertMessage)),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      barrierDismissible: isBarrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showLoadingDialog({required BuildContext context, required String text, bool isBarrierDismissible = false}) {
    AlertDialog alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(40),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Container(margin: EdgeInsets.only(left: 20), child: Text(text)),
            ],
          ),
        ));

    showDialog(
      barrierDismissible: isBarrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  static void showLoadingDialogFullScreen({required BuildContext context, required String text, bool isBarrierDismissible = false, Color? barrierColor = Colors.white}) {
    AlertDialog alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(40),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Container(margin: EdgeInsets.only(left: 20), child: Text(text)),
            ],
          ),
        ));

    showDialog(
      barrierColor: barrierColor,
      barrierDismissible: isBarrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  static void showRetryDialogFullScreen({required BuildContext? context, String retryText = "Retry", Function()? retryFunction, String? message, bool isBarrierDismissible = false, Color? barrierColor = Colors.white}) {
    if(context != null) {
      AlertDialog alertDialog = AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: RetryWidget(message: message ?? "", retryFunction: retryFunction, retryText: retryText,));

      showDialog(
        barrierColor: barrierColor,
        barrierDismissible: isBarrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false,child: alertDialog);
        },
      );
    }
  }


  static onScreenPop({required BuildContext context, var result}) {
    return Navigator.pop(context, result);
  }

  static void hideKeyboard({required BuildContext context, Function? setState}) {
    if (setState != null) {
      setState(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  static Widget buttonWidthMatchParent(
      {required BuildContext context,
      required String title,
      double height = 50,
      Color fillColor = Colors.white,
      Color borderColor = ColorConstant.grey_1,
      Color textColor = ColorConstant.grey_1,
      double fontSize = 18,
      double borderRadius = 8,
      EdgeInsetsGeometry padding = const EdgeInsets.all(5),
      EdgeInsetsGeometry margin = const EdgeInsets.all(0),
      required Function() onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: margin,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: padding,
              height: height,
              child: Text(
                title,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fillColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget button1(
      {required BuildContext context,
      required String title,
      double height = 50,
      double width = 100,
      Color fillColor = Colors.white,
      Color borderColor = ColorConstant.grey_1,
      Color textColor = ColorConstant.grey_1,
      double fontSize = 18,
      double borderRadius = 8,
      EdgeInsetsGeometry padding = const EdgeInsets.all(5),
      EdgeInsetsGeometry margin = const EdgeInsets.all(0),
      required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: margin,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: padding,
              height: height,
              width: width,
              child: Text(
                title,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fillColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget imageWIthText_1(
      {required String title,
        IconData? faIcon,
        Color faIconColor = Colors.black,
        String imageAsset = "",
        Function()? function,
        double fontSize = 14,
        FontWeight fontWeight = FontWeight.normal,
        Color fontColor = Colors.black,
        double iconSize = 60}) {
    return InkWell(
      onTap: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageAsset.trim().length > 0
              ? Container(
            height: iconSize,
            width: iconSize,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageAsset),
                fit: BoxFit.cover,
              ),
            ),
          )
              : faIcon != null
              ? Icon(
            faIcon,
            size: iconSize,
            color: faIconColor,
          )
              : Icon(
            Icons.circle,
            size: iconSize,
            color: faIconColor,
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(1),
            child: Text(
              title,
              style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
            ),
          )
        ],
      ),
    );
  }
}
