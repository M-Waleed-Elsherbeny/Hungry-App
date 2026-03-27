import 'package:dio/dio.dart';
import 'package:hungry_app/core/networking/api_errors.dart';

class ApiExceptions {
  static handelError(DioException error){
    switch(error.type){
      case DioExceptionType.receiveTimeout:
        return ApiErrors(message: "Connection Time Out");
      case DioExceptionType.sendTimeout:
        return ApiErrors(message: "Send Time Out");
      case DioExceptionType.connectionError:
        return ApiErrors(message: "Connection Error");
      case DioExceptionType.badResponse:
        return ApiErrors(message: error.response!.data['message']);
      case DioExceptionType.connectionTimeout:
        return ApiErrors(message: "Connection Time Out");
      default:
        return ApiErrors(message: "OPS Something went wrong");
    }
  }
}