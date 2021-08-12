import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'validation_utils.dart';

enum INPUT_TYPE {
  ALPHA,
  ALPHA_WITH_SPACE,
  ALPHA_NUMERIC,
  ALPHA_NUMERIC_WITH_SPACE,
  ALPHA_NUMERIC_SPECIAL_CHAR,
  NUMERIC,
  NUMERIC_FLOAT,
  NUMERIC_INT,
  EMAIL,
  MOBILE
}

class InputTypeUtils {
  static TextInputType getTextInputType(INPUT_TYPE inputType) {
    if (inputType != null) {
      if (inputType == INPUT_TYPE.ALPHA) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.ALPHA_WITH_SPACE) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC_WITH_SPACE) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC_SPECIAL_CHAR) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.NUMERIC) {
        return TextInputType.number;
      } else if (inputType == INPUT_TYPE.NUMERIC_FLOAT) {
        return TextInputType.number;
      } else if (inputType == INPUT_TYPE.NUMERIC_INT) {
        return TextInputType.number;
      } else if (inputType == INPUT_TYPE.MOBILE) {
        return TextInputType.phone;
      } else if (inputType == INPUT_TYPE.EMAIL) {
        return TextInputType.emailAddress;
      } else {
        return TextInputType.text;
      }
    } else {
      return TextInputType.text;
    }
  }

  static List<TextInputFormatter> getTextInputFormatter(INPUT_TYPE inputType) {
    RegExp regExp = ValidationUtils.ALPHANUMERIC;
    if (inputType != null) {
      if (inputType == INPUT_TYPE.ALPHA) {
        regExp = ValidationUtils.ALPHA;
      } else if (inputType == INPUT_TYPE.ALPHA_WITH_SPACE) {
        regExp = ValidationUtils.ALPHA_WITH_SPACE;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC) {
        regExp = ValidationUtils.ALPHANUMERIC;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC_WITH_SPACE) {
        regExp = ValidationUtils.ALPHANUMERIC_WITH_SPACE;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC_SPECIAL_CHAR) {
        regExp = ValidationUtils.ALPHANUMERIC_SPECIAL_CHAR;
      } else if (inputType == INPUT_TYPE.NUMERIC) {
        regExp = ValidationUtils.NUMERIC;
      } else if (inputType == INPUT_TYPE.NUMERIC_FLOAT) {
        regExp = ValidationUtils.FLOAT;
      } else if (inputType == INPUT_TYPE.NUMERIC_INT) {
        regExp = ValidationUtils.INT;
      } else if (inputType == INPUT_TYPE.MOBILE) {
        regExp = ValidationUtils.MOBILE_NUMBER;
      } else if (inputType == INPUT_TYPE.EMAIL) {
        regExp = ValidationUtils.ALPHANUMERIC_SPECIAL_CHAR;
      } else {
        regExp = ValidationUtils.ALPHANUMERIC_SPECIAL_CHAR;
      }
    } else {
      regExp = ValidationUtils.ALPHANUMERIC_SPECIAL_CHAR;
    }

    return <TextInputFormatter>[FilteringTextInputFormatter.allow(regExp)];
  }
}
