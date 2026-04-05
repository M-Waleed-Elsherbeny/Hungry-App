import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:hungry_app/core/constants/api_constant.dart';

class DioHandler {
  static Dio? dio;
  static Dio? initialDio() {
    const Duration timeout = Duration(seconds: 30);
    if (dio == null) {
      dio = Dio();
      dio!.options.baseUrl = ApiConstants.baseUrl;
      dio!.options.connectTimeout = timeout;
      dio!.options.receiveTimeout = timeout;
      dioLogger();
      return dio;
    } else {
      dioLogger();
      return dio;
    }
  }

  static void dioLogger() {
    dio!.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        maxWidth: 90,
      ),
    );
  }
}
