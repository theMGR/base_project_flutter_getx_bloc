import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project/core/utils/input_type_utils.dart';
import 'package:project/ui/config/ui_config.dart';

import 'login_controller.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.find<LoginController>();
  final LoginState state = Get.find<LoginController>().state;
  TextEditingController tecMobileNo = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: UIConfig.scrollListView(margin: EdgeInsets.all(30), children: [
            Text(
              "login".tr,
              style: TextStyle(fontSize: 30, color: UIConfig.primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            UIConfig.textFieldLabel(
              inputType: INPUT_TYPE.NUMERIC_INT,
              length: 10,
              textEditingController: tecMobileNo,
              focusNode: state.fnUserName,
              requestFocusNode: state.fnPassword,
              textInputAction: TextInputAction.next,
              context: context,
              labelText: "mobileNumber".tr,
              labelTextColor: UIConfig.primaryColor,
              borderColor: UIConfig.primaryColor,
              disabledBorderColor: UIConfig.primaryColor,
              enabledBorderColor: UIConfig.primaryColor,
              errorBorderColor: UIConfig.primaryColor,
              focusedBorderColor: UIConfig.accentColor,
              focusedErrorBorderColor: UIConfig.primaryColor,
              prefixIcon: Icon(FontAwesomeIcons.mobileAlt, color: UIConfig.primaryColor),
              onTextChanged: (String value) {
                //
              },
            ),
            SizedBox(height: 20),
            UIConfig.textFieldLabel(
              obscureText: true,
              textEditingController: tecPassword,
              focusNode: state.fnPassword,
              context: context,
              labelText: "password".tr,
              labelTextColor: UIConfig.primaryColor,
              borderColor: UIConfig.primaryColor,
              disabledBorderColor: UIConfig.primaryColor,
              enabledBorderColor: UIConfig.primaryColor,
              errorBorderColor: UIConfig.primaryColor,
              focusedBorderColor: UIConfig.accentColor,
              focusedErrorBorderColor: UIConfig.primaryColor,
              prefixIcon: Icon(FontAwesomeIcons.lock, color: UIConfig.primaryColor),
              onTextChanged: (String value) {
                //
              },
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: UIConfig.button(
                  width: 100,
                  context: context,
                  fillColor: UIConfig.buttonColor,
                  textColor: UIConfig.buttonTextColor,
                  title: "submit".tr,
                  onTap: () {
                    UIConfig.hideKeyboard(context: context);
                    controller.getUserByMobileNo(tecMobileNo.text, tecPassword.text);
                    //Get.offAllNamed(ExamplePage.route);
                  }),
            )
          ])),
          //Container(alignment: Alignment.center, child: LanguagePage()),
        ],
      )),
    );
  }

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }
}
