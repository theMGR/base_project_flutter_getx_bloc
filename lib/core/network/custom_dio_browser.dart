import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';

import 'custom_dio_interceptor.dart';
import 'custom_pretty_dio_logger.dart';

class CustomDio extends DioForBrowser {
  CustomDio({BaseOptions? options, Interceptor? interceptor}) : super(options) {
    options = BaseOptions(connectTimeout: Duration(minutes: 5).inSeconds, receiveTimeout: Duration(minutes: 5).inSeconds, contentType: Headers.jsonContentType, responseType: ResponseType.json);

    CustomDioInterceptor customDioInterceptor =
        CustomDioInterceptor(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true);
    CustomPrettyDioLogger customPrettyDioLogger = CustomPrettyDioLogger(
        isPrintRawJSON: false, requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90);

    interceptors.add(interceptor != null ? interceptor : customPrettyDioLogger);
  }
}
