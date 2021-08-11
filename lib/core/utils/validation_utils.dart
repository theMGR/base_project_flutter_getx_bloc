
// ignore_for_file: non_constant_identifier_names
import 'email_validator.dart';

class ValidationUtils {
  static RegExp ALPHA = RegExp(r'^[a-zA-Z]+$');
  static RegExp ALPHA_WITH_SPACE = RegExp(r'^[a-zA-Z\s]+$');
  static RegExp ALPHANUMERIC = RegExp(r'^[a-zA-Z0-9]+$');
  static RegExp ALPHANUMERIC_WITH_SPACE = RegExp(r'^[a-zA-Z0-9\s]+$');
  static RegExp ALPHANUMERIC_SPECIAL_CHAR = RegExp(r"^[ A-Za-z0-9_@./#&+-]*$");
  static RegExp NUMERIC = RegExp(r'^-?[0-9]+$');
  static RegExp INT = RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
  static RegExp FLOAT = RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
  static RegExp PAN = RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]");
  static RegExp MOBILE_NUMBER = RegExp(r"^[6789][0-9]{9}");
  static RegExp PIN_CODE = RegExp(r"^[1-9][0-9]{5}");
  static RegExp GST_NUMBER = RegExp(r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}");

  // 8-16 characters password with at least one digit,
  // at least one lowercase letter at least one uppercase letter,
  // at least one special character with no whitespaces
  static RegExp PASSWORD = RegExp(r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,16}$");

  static bool isValidPAN({required String pan}) {
    return PAN.hasMatch(pan.trim());
  }

  static bool isValidMobileNumber({required String mobileNumber}) {
    return MOBILE_NUMBER.hasMatch(mobileNumber.trim());
  }

  static bool isValidPinCode({required String pin}) {
    return PIN_CODE.hasMatch(pin.trim());
  }

  static bool isValidEmail({required String email}) {
    return EmailValidator.validate(email);
  }

  static bool isValidGSTIN({required String gstNumber}) {
    return GST_NUMBER.hasMatch(gstNumber.trim());
  }

  static bool isAlpha({required String text}) {
    return ALPHA.hasMatch(text.trim());
  }

  static bool isAlphaNumeric({required String text}) {
    return ALPHANUMERIC.hasMatch(text.trim());
  }

  static bool isNumeric({required String text}) {
    return NUMERIC.hasMatch(text.trim());
  }

  static bool isNumericInt({required String text}) {
    return INT.hasMatch(text.trim());
  }

  static bool isNumericFloat({required String text}) {
    return FLOAT.hasMatch(text.trim());
  }

  static bool isEmpty(String? val) {
    //return (val != null && val.isNotEmpty && !val.toLowerCase().contains("null") && val.trim().length > 0) ? false : true;
    try {
      return (val != null && val.isNotEmpty && !val.toLowerCase().contains("null") && val.trim().length > 0) ? false : true;
    } catch (e) {
      return true;
    }
  }

  static bool isValidPassword_Min8_Char_Caps_AlphaNumeric({required String password}) {
    return PASSWORD.hasMatch(password.trim());
  }

  static bool isNumericIntOrDouble(String val) {
    if (isEmpty(val)) {
      return false;
    }
    return double.tryParse(val) != null;
  }

  static int getInt(String s) {
    try {
      return int.parse(s);
    } catch (e) {
      return 0;
    }
  }

  static double getDouble(String s) {
    try {
      return double.parse(s);
    } catch (e) {
      return 0.0;
    }
  }

  static num getNum(String s) {
    try {
      return num.parse(s);
    } catch (e) {
      return 0;
    }
  }

  static String getValueFromString(String val) {
    return isEmpty(val) ? "-" : val;
  }

  static String getValueFromInt(int val) {
    return getInt(val.toString()) > 0 ? "$val" : "-";
  }

  static String getValueFromDouble(double val) {
    return getDouble(val.toString()) > 0 ? "$val" : "-";
  }

  static String getValueFromNum(num val) {
    return getNum(val.toString()) > 0 ? "$val" : "-";
  }
}
