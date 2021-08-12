import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/core/exceptions/custom_exception.dart';
import 'package:project/core/utils/network_utils.dart';
import 'package:project/core/utils/ui_utils.dart';
import 'package:project/core/widgets/retry_widget/retry_widget.dart';

import 'no_network.dart';

enum AppExceptionsUIType { SHOW_RETRY_DIALOG_FULL_SCREEN, SHOW_RETRY_DIALOG, SHOW_DIALOG, SHOW_TOAST }

// ignore_for_file: non_constant_identifier_names
class AppExceptions implements Exception {
  String _errorMessage = "Unexpected error occurred";
  NETWORK_ERROR_TYPE _network_error_type = NETWORK_ERROR_TYPE.UNEXPECTED_ERROR;
  Object _exception = CustomException(message: "App Exceptions init");
  Function()? _retryFunction;

  AppExceptions(
      {required Object exception,
      BuildContext? context,
      Function()? retryFunction,
      String? message,
      String alertTitle = "Alert",
      AppExceptionsUIType? appExceptionsUIType,
      String retryText = "Retry",
      bool isBarrierDismissible = false}) {
    _exception = exception;
    _retryFunction = retryFunction;
    if (exception is SocketException) {
      _errorMessage = "No internet connection";
      _network_error_type = NETWORK_ERROR_TYPE.NO_INTERNET_CONNECTION;
    } else if (exception is DioError) {
      _getDioException(exception);
    } else if (exception is NoNetwork) {
      _errorMessage = "No internet connection";
      _network_error_type = NETWORK_ERROR_TYPE.NO_INTERNET_CONNECTION;
    } else if (exception is CustomException) {
      _errorMessage = _exception.toString();
      _network_error_type = NETWORK_ERROR_TYPE.CUSTOM_EXCEPTION;
    } else if (exception is FormatException) {
      _errorMessage = "Unexpected error occurred";
      _network_error_type = NETWORK_ERROR_TYPE.UNEXPECTED_ERROR;
    } else if (exception.toString().contains("is not a subtype of")) {
      _errorMessage = "Unable to process the data";
      _network_error_type = NETWORK_ERROR_TYPE.UNABLE_TO_PROCESS;
    } else {
      _errorMessage = "Unexpected error occurred";
      _network_error_type = NETWORK_ERROR_TYPE.UNEXPECTED_ERROR;
    }

    if (appExceptionsUIType != null) {
      switch (appExceptionsUIType) {
        case AppExceptionsUIType.SHOW_RETRY_DIALOG_FULL_SCREEN:
          if (retryFunction != null) {
            UIUtils.showRetryDialogFullScreen(
                context: context, retryFunction: retryFunction, retryText: retryText, message: message, isBarrierDismissible: isBarrierDismissible);
          }
          break;
        case AppExceptionsUIType.SHOW_RETRY_DIALOG:
          if (retryFunction != null && message != null) {
            UIUtils.showAlertDialogOkFunction(
                function: retryFunction,
                okText: retryText,
                context: context,
                alertTitle: alertTitle,
                alertMessage: message,
                isBarrierDismissible: isBarrierDismissible);
          }
          break;
        case AppExceptionsUIType.SHOW_DIALOG:
          if (message != null) {
            UIUtils.showAlertDialog(
                context: context,
                alertTitle: alertTitle,
                alertMessage: message,
                isBarrierDismissible: isBarrierDismissible);
          }
          break;
        case AppExceptionsUIType.SHOW_TOAST:
          if (message != null) {
            UIUtils.showToast(context: context, message: message);
          }
          break;
      }
    }
  }

  @override
  String toString() {
    return 'AppExceptions{errorMessage:-> $_errorMessage}';
  }

  Widget showRetryScreen() {
    return RetryWidget(message: _errorMessage, retryFunction: _retryFunction);
  }

  void showToast({required BuildContext context}) {
    UIUtils.showToast(context: context, message: _errorMessage);
  }

  void showAlert({required BuildContext context, String alert = "Alert", bool isBarrierDismissible = true}) {
    UIUtils.showAlertDialog(context: context, alertTitle: alert, alertMessage: _errorMessage, isBarrierDismissible: isBarrierDismissible);
  }

  NETWORK_ERROR_TYPE getErrorType() => _network_error_type;

  String getErrorMessage() => _errorMessage;

  Object getException() => _exception;

  NETWORK_ERROR_TYPE _handleResponse(int? statusCode) {
    switch (statusCode) {
      case 400:
        _errorMessage = "Bad request";
        return NETWORK_ERROR_TYPE.BAD_REQUEST_400;
      case 401:
        _errorMessage = "Unauthorized request: 401";
        return NETWORK_ERROR_TYPE.UNAUTHORIZED_REQUEST_401;
      case 403:
        _errorMessage = "Forbidden request: 403";
        return NETWORK_ERROR_TYPE.FORBIDDEN_403;
      case 404:
        _errorMessage = "Not found: 404";
        return NETWORK_ERROR_TYPE.NOT_FOUND_404;
      case 409:
        _errorMessage = "Error due to a conflict: 409";
        return NETWORK_ERROR_TYPE.CONFLICT_409;
      case 408:
        _errorMessage = "Connection request timeout: 408";
        return NETWORK_ERROR_TYPE.REQUEST_TIME_OUT_408;
      case 500:
        _errorMessage = "Internal Server Error: 500";
        return NETWORK_ERROR_TYPE.INTERNAL_SERVER_ERROR_500;
      case 503:
        _errorMessage = "Service unavailable: 503";
        return NETWORK_ERROR_TYPE.SERVICE_UNAVAILABLE_503;
      default:
        _errorMessage = "Received invalid status code: $statusCode";
        return NETWORK_ERROR_TYPE.INVALID_STATUS_CODE;
    }
  }

  NETWORK_ERROR_TYPE _getDioException(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = "Request Cancelled";
        return NETWORK_ERROR_TYPE.REQUEST_CANCELLED;
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection request timeout";
        return NETWORK_ERROR_TYPE.REQUEST_TIME_OUT_408;
      case DioErrorType.other:
        if (error.message.contains("SocketException: Connection failed")) {
          _errorMessage = "No internet connection";
          _network_error_type = NETWORK_ERROR_TYPE.NO_INTERNET_CONNECTION;
        } else {
          _errorMessage = "Dio Error.Default -> Unexpected error occurred";
          _network_error_type = NETWORK_ERROR_TYPE.DIO_DEFAULT;
        }
        return _network_error_type;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Connection receive timeout";
        return NETWORK_ERROR_TYPE.RECEIVE_TIME_OUT;
      case DioErrorType.response:
        return _handleResponse(error.response?.statusCode);
      case DioErrorType.sendTimeout:
        _errorMessage = "Send timeout in connection with API server";
        return NETWORK_ERROR_TYPE.SEND_TIME_OUT;
      default:
        _errorMessage = "Unexpected error occurred";
        return NETWORK_ERROR_TYPE.UNEXPECTED_ERROR;
    }
  }
}
