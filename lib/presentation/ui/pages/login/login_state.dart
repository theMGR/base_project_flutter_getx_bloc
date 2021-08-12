import 'package:flutter/cupertino.dart';

class LoginState {
  var fnUserName;
  var fnPassword;
  LoginState() {
    ///Initialize variables
    fnUserName = FocusNode();
    fnPassword = FocusNode();
  }
}
