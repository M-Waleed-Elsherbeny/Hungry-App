import 'package:dio/dio.dart';
import 'package:hungry_app/core/networking/api_errors.dart';

class ApiExceptions {
  static handelError(DioException error){
    switch(error.type){
      case DioExceptionType.receiveTimeout:
        return ApiErrors(message: "Connection Timeout");
      case DioExceptionType.sendTimeout:
        return ApiErrors(message: "Send Timeout");
      case DioExceptionType.connectionError:
        return ApiErrors(message: error.message!);
      case DioExceptionType.badResponse:
        return ApiErrors(message: error.message!);
      case DioExceptionType.connectionTimeout:
        return ApiErrors(message: "Connection Timeout");
      default:
        return ApiErrors(message: "Something went wrong");
    }
  }
}