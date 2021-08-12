import 'package:project/core/utils/validation_utils.dart';

class CustomException implements Exception {
  final String message;

  CustomException({required this.message});

  @override
  String toString() {
    return ValidationUtils.isEmpty(message) ? "Something went wrong!" : message;
  }
}
