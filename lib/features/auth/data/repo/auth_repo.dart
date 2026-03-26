import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry_app/core/constants/api_constant.dart';
import 'package:hungry_app/core/networking/api_errors.dart';
import 'package:hungry_app/core/networking/api_exceptions.dart';
import 'package:hungry_app/core/networking/api_services.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';

class AuthRepo {
  final ApiServices _apiServices = ApiServices();

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
      final response = await _apiServices.post(ApiConstants.loginEndPoint, {
        "email": email,
        "password": password,
      });
    try {
      final UserModel user = UserModel.fromJson(response["data"]);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return user;
    } on DioException catch (_) {
      throw ApiExceptions.handelError(response["message"]);
    } catch (e) {
      log(e.toString());
      throw ApiErrors(message: response.toString());
    }
  }
}
