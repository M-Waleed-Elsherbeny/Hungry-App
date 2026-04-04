import 'package:hungry_app/core/networking/dio_handler.dart';

class ApiServices {
  final DioHandler _dioHandler = DioHandler();

  Future<dynamic> get(String endPoint) async {
    final response = await _dioHandler.dio.get(endPoint);
    return response.data;
  }

  Future<dynamic> post(String endPoint, dynamic data) async {
    final response = await _dioHandler.dio.post(endPoint, data: data);
    return response.data;
  }

  Future<dynamic> put(String endPoint, dynamic data) async {
    final response = await _dioHandler.dio.put(endPoint, data: data);
    return response.data;
  }

  Future<dynamic> delete(String endPoint, Map<String, dynamic> data) async {
    final response = await _dioHandler.dio.delete(endPoint, data: data);
    return response.data;
  }
}
