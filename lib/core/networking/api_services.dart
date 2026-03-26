import 'package:dio/dio.dart';
import 'package:hungry_app/core/networking/api_exceptions.dart';
import 'package:hungry_app/core/networking/dio_handler.dart';

class ApiServices {
  final DioHandler _dioHandler = DioHandler();

  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioHandler.dio.get(endPoint);
      return response.data;
    } on DioException catch (error) {
      return ApiExceptions.handelError(error);
    }
  }

  Future<dynamic> post(String endPoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioHandler.dio.post(endPoint, data: data);
      return response.data;
    } on DioException catch (error) {
      return ApiExceptions.handelError(error);
    }
  }

  Future<dynamic> put(String endPoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioHandler.dio.put(endPoint, data: data);
      return response.data;
    } on DioException catch (error) {
      return ApiExceptions.handelError(error);
    }
  }

  Future<dynamic> delete(String endPoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioHandler.dio.delete(endPoint, data: data);
      return response.data;
    } on DioException catch (error) {
      return ApiExceptions.handelError(error);
    }
  }
}
