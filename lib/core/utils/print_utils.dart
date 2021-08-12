/*
Black:   \x1B[30m
Red:     \x1B[31m
Green:   \x1B[32m
Yellow:  \x1B[33m
Blue:    \x1B[34m
Magenta: \x1B[35m
Cyan:    \x1B[36m
White:   \x1B[37m
Reset:   \x1B[0m
*/

// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/foundation.dart' as Foundation;

enum PRINT_TYPE { DEFAULT, WARNING, ERROR, SUCCESS, INFO }


class Print {
  static const String _black = "\x1B[30m";
  static const String _red = "\x1B[31m";
  static const String _green = "\x1B[32m";
  static const String _yellow = "\x1B[33m";
  static const String _blue = "\x1B[34m";
  static const String _magenta = "\x1B[35m";
  static const String _cyan = "\x1B[36m";
  static const String _white = "\x1B[37m";
  static const String _reset = "\x1B[0m";
  static const String _purpleLight =  "\x1B[38;2;153;0;153m"; //RGB
  static const String _navyLight = "\x1B[38;2;84;140;168m"; //RGB

  Print(Object text, {bool isPrint = true, bool isLog = false, PRINT_TYPE printType = PRINT_TYPE.DEFAULT}) {
    if(Foundation.kDebugMode) {
      if (printType == PRINT_TYPE.DEFAULT) {
        Default(text, isLog: isLog, isPrint: isPrint);
      } else if (printType == PRINT_TYPE.ERROR) {
        Error(text, isLog: isLog, isPrint: isPrint);
      } else if (printType == PRINT_TYPE.SUCCESS) {
        Success(text, isLog: isLog, isPrint: isPrint);
      } else if (printType == PRINT_TYPE.INFO) {
        Info(text, isLog: isLog, isPrint: isPrint);
      } else if (printType == PRINT_TYPE.WARNING) {
        Warning(text, isLog: isLog, isPrint: isPrint);
      }
    }
  }

  static void Warning(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _yellow;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void Default(Object? text, {bool isPrint = true, bool isLog = false}) {
    if (isPrint && text != null) {
      String message = text.toString();
      if (isLog) {
        log(message);
      } else {
        print(message);
      }
    }
  }

  static void Error(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _red;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void Success(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _green;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void Info(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _blue;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void Debug(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _navyLight;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void Reference(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _purpleLight;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

}
