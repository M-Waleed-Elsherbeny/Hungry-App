import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:hungry_app/core/constants/api_constant.dart';

class DioHandler {
  Dio _dio = Dio();

  Future<void> init() async {
    final String? token = await PrefHelper.getToken();
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: token != null
            ? {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }
            : {'Content-Type': 'application/json'},
      ),
    );
    log(dio.options.baseUrl);
    dioLogger();
  }

  void dioLogger() {
    _dio.interceptors.add(
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

  DioHandler() {
    init();
  }

  Dio get dio => _dio;
}
