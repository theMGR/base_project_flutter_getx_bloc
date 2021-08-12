import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import 'custom_dio_interceptor.dart';
import 'custom_pretty_dio_logger.dart';
//import 'package:flutter/foundation.dart' as Foundation;

class CustomDio extends DioForNative {
  CustomDio({BaseOptions? options, Interceptor? interceptor}) : super(options) {
    options = BaseOptions(connectTimeout: Duration(minutes: 5).inSeconds, receiveTimeout: Duration(minutes: 5).inSeconds, contentType: Headers.jsonContentType, responseType: ResponseType.json);

/*    if(Foundation.kIsWeb) {
      httpClientAdapter = BrowserHttpClientAdapter();
    }*/

    CustomDioInterceptor customDioInterceptor =
        CustomDioInterceptor(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true);
    CustomPrettyDioLogger customPrettyDioLogger = CustomPrettyDioLogger(
        isPrintRawJSON: true, requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90);

    interceptors.add(interceptor != null ? interceptor : customPrettyDioLogger);
  }
}