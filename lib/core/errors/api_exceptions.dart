import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry_app/core/errors/api_errors.dart';

class ApiExceptions {
  static ApiErrors handelError(DioException error) {
    final statusCode = int.parse(error.response?.statusCode.toString() ?? "0");
    final data = error.response?.data;

    if (statusCode != 0) {
      if (data is Map<String, dynamic> && data["message"] != null) {
        log("ApiExceptions: ${error.message}");
        log("Status Code: ${error.response?.statusCode}");
        return ApiErrors(message: data['message']);
      }
    }
    if (statusCode == 302) {
      return ApiErrors(message: "The email has already been taken.");
    }
    log("ApiExceptions: ${error.message}");
    log("Status Code: ${error.response?.statusCode}");

    switch (error.type) {
      case DioExceptionType.receiveTimeout:
        return ApiErrors(message: "Connection Time Out");
      case DioExceptionType.sendTimeout:
        return ApiErrors(message: "Send Time Out");
      case DioExceptionType.connectionError:
        return ApiErrors(message: "Connection Error");
      case DioExceptionType.connectionTimeout:
        return ApiErrors(message: "Connection Time Out");
      default:
        return ApiErrors(message: "OPS Something went wrong");
    }
  }
}
