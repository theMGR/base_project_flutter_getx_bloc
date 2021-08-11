// ignore_for_file: non_constant_identifier_names
class DataConstants {
  static String BEARER_TOKEN_PREFIX = 'Bearer ';

  static String SUCCESS = 'Success';
  static String FAILED = 'Failed';
  static String FAILURE = 'Failure';

  static bool isSuccessStatus(String status) {
    return SUCCESS.toLowerCase().compareTo(status.toLowerCase()) == 0;
  }
}