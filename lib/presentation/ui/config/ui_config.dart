import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/utils/input_type_utils.dart';
import 'package:project/core/utils/validation_utils.dart';
import 'package:project/presentation/res/colors/app_colors/app_colors.dart';

/// get customised widgets
class UIConfig {
  static Color? iconColor =  AppColors.get()?.ICON_COLOR != null ? AppColors.get()?.ICON_COLOR! : Colors.grey;
  static Color? buttonColor = AppColors.get()?.BUTTON_COLOR != null ? AppColors.get()?.BUTTON_COLOR : Colors.black54;
  static Color? buttonTextColor =  AppColors.get()?.BUTTON_TEXT_COLOR != null ? AppColors.get()?.BUTTON_TEXT_COLOR : Colors.white;
  static Color? primaryColor = AppColors.get()?.PRIMARY_COLOR != null ? AppColors.get()?.PRIMARY_COLOR : Colors.blue;
  static Color? accentColor =  AppColors.get()?.ACCENT_COLOR != null ? AppColors.get()?.ACCENT_COLOR : Colors.blueGrey;
  /// get customised Theme data
  static ThemeData themeData() {

    return ThemeData(
        //brightness: Brightness.dark,
        primaryColor: primaryColor,
        accentColor: accentColor,
        fontFamily: 'Ubuntu',
        /*textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ).apply(),
        iconTheme: IconThemeData(color: Colors.white),
        scaffoldBackgroundColor: Colors.white*/);
  }

  static Scaffold scaffold({AppBar? appBar, required Widget body}) {
    return Scaffold(appBar: appBar, body: body);
  }

  static AppBar appBar() {
    return AppBar();
  }

  /// scroll list view
  static scrollListView(
      {required List<Widget> children,
      Axis scrollDirection = Axis.vertical,
      AlignmentGeometry alignment = Alignment.center,
      double? width,
      double? height,
      bool shrinkWrap = true,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin}) {
    return Container(
        padding: padding,
        margin: margin,
        alignment: alignment,
        width: width,
        height: height,
        child: ListView(
          children: children,
          scrollDirection: scrollDirection,
          shrinkWrap: shrinkWrap,
        ));
  }

  /// text field: title - show above text field, labelText - show label in text filed left side in top border line,
  static Widget textFieldLabel(
      {TextEditingController? textEditingController,
      String title = "",
      String hintText = "",
      String? labelText,
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
      TextStyle? labelTextStyle,
      Color? titleColor = Colors.black45,
      Color? textColor = Colors.black,
      Color? hintTextColor = Colors.grey,
      Color? labelTextColor = Colors.grey,
      double borderRadius = 0,
      Color? borderColor = Colors.grey,
      Color? focusedBorderColor = Colors.grey,
      Color? enabledBorderColor = Colors.grey,
      Color? disabledBorderColor = Colors.grey,
      Color? errorBorderColor = Colors.grey,
      Color? focusedErrorBorderColor = Colors.grey,
      Widget? prefixIcon,
      Widget? suffixIcon,
      bool obscureText = false,
      String obscuringCharacter = ".",
      EdgeInsetsGeometry textFieldContentPadding = const EdgeInsets.all(5),
      BuildContext? context,
      FocusNode? focusNode,
      FocusNode? requestFocusNode,
      TextInputAction? textInputAction = TextInputAction.done}) {
    TextEditingController tec = textEditingController ?? TextEditingController();
    FocusNode fn = focusNode ?? FocusNode();
    FocusNode rfn = requestFocusNode ?? FocusNode();
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
          textInputAction: textInputAction,
          focusNode: fn,
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
          onEditingComplete: () {
            tec.text = tec.text;
            Get.printInfo(info: "onEditingComplete ${tec.text}");
            if (context != null) {
              FocusScope.of(context).requestFocus(rfn);
            }
          },
          onSubmitted: (String value) {
            tec.text = value;
            Get.printInfo(info: "onSubmitted ${tec.text}");
            if (context != null) {
              FocusScope.of(context).requestFocus(rfn);
            }
          },
          controller: tec,
          keyboardType: InputTypeUtils.getTextInputType(inputType),
          inputFormatters: InputTypeUtils.getTextInputFormatter(inputType),
          enabled: isEditable,
          style: textStyle == null ? TextStyle(color: textColor, fontSize: textSize) : textStyle,
          decoration: InputDecoration(
            contentPadding: textFieldContentPadding,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: enabledBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: disabledBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedErrorBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            hintText: hintText,
            labelText: labelText,
            hintStyle: hintTextStyle == null ? TextStyle(color: hintTextColor) : hintTextStyle,
            labelStyle: labelTextStyle == null ? TextStyle(color: labelTextColor) : labelTextStyle,
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

  /// common button
  static Widget button(
      {required BuildContext context,
      required String title,
      double? height = 50,
      double? width,
      bool isMatchParent = false,
      Color? fillColor = Colors.white,
      Color? borderColor,
      Color? textColor = Colors.grey,
      double? fontSize,
      double borderRadius = 0,
      EdgeInsetsGeometry padding = const EdgeInsets.all(5),
      EdgeInsetsGeometry margin = const EdgeInsets.all(0),
      required Function() onTap,
      TextAlign textAlign = TextAlign.start}) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: padding,
          child: Text(
            title,
            textAlign: textAlign,
            style: TextStyle(color: textColor, fontSize: fontSize),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fillColor,
            border: borderColor != null ? Border.all(color: borderColor) : null,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
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

  /// add icon with text or add widget with icon
  static RichText richText({List<InlineSpan>? children}) {
    return RichText(
      text: TextSpan(
        children: children,
      ),
    );
  }
}
