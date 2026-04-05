import 'package:dio/dio.dart';
import 'package:hungry_app/core/networking/dio_handler.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';

class ApiServices {
  Dio? dio;
  ApiServices() {
    dio = DioHandler.initialDio();
  }

  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? headers,
  }) async {
    final String? token = await PrefHelper.getToken();
    final response = await dio!.get(
      endPoint,
      options: Options(
        headers: token != null
            ? {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }
            : {'Content-Type': 'application/json'},
      ),
    );
    return response.data;
  }

  Future<dynamic> post({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    final String? token = await PrefHelper.getToken();
    final response = await dio!.post(
      endPoint,
      data: data,
      options: Options(
        headers: token != null
            ? {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }
            : {'Content-Type': 'application/json'},
      ),
    );
    return response.data;
  }

  Future<dynamic> put({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    final String? token = await PrefHelper.getToken();

    final response = await dio!.put(
      endPoint,
      data: data,
      options: Options(
        headers: token != null
            ? {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }
            : {'Content-Type': 'application/json'},
      ),
    );
    return response.data;
  }

  Future<dynamic> delete({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    final String? token = await PrefHelper.getToken();

    final response = await dio!.delete(
      endPoint,
      data: data,
      options: Options(
        headers: token != null
            ? {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }
            : {'Content-Type': 'application/json'},
      ),
    );
    return response.data;
  }
}
