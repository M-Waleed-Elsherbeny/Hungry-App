import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/constants/api_constant.dart';
import 'package:hungry_app/core/errors/api_errors.dart';
import 'package:hungry_app/core/errors/api_exceptions.dart';
import 'package:hungry_app/core/networking/api_services.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';

class AuthRepo {
  final ApiServices _apiServices = ApiServices();

  /// Login
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
    } on DioException catch (e) {
      log("DioException login");
      throw ApiExceptions.handelError(e);
    } on ApiErrors catch (e) {
      log("ApiErrors login");
      throw ApiErrors(message: e.message);
    } catch (e) {
      log("Catch login");
      throw ApiErrors(message: response.toString());
    }
  }

  /// Sign Up
  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _apiServices.post(ApiConstants.signUpEndPoint, {
      "name": name,
      "email": email,
      "password": password,
    });
    try {
      final UserModel user = UserModel.fromJson(response["data"]);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return user;
    } on DioException catch (e) {
      log("DioException signUp");
      throw ApiExceptions.handelError(e);
    } on ApiErrors catch (e) {
      log("ApiErrors signUp");
      throw ApiErrors(message: e.message);
    } catch (e) {
      log("Catch signUp");
      throw ApiErrors(message: response.toString());
    }
  }

  /// Profile
  Future<UserModel?> getProfileData() async {
    final response = await _apiServices.get(ApiConstants.profileEndPoint);
    try {
      UserModel user = UserModel.fromJson(response["data"]);
      return user;
    } on DioException catch (e) {
      log("DioException getProfileData");
      throw ApiExceptions.handelError(e);
    } on ApiErrors catch (e) {
      log("ApiErrors getProfileData");
      throw ApiErrors(message: e.message);
    } catch (e) {
      log("Catch getProfileData");
      throw ApiErrors(message: response.toString());
    }
  }

  /// Update Profile
  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String phone,
    required String? image,
    required String address,
    required String? visa,
  }) async {
    final formData = FormData.fromMap({
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      if (image != null && image.isNotEmpty)
        "image": await MultipartFile.fromFile(image, filename: "profile.jpg"),
      if (visa != null && visa.isNotEmpty) "Visa": visa,
    });
    final response = await _apiServices.post(
      ApiConstants.updateProfileEndPoint,
      formData,
    );
    try {
      final UserModel user = UserModel.fromJson(response["data"]);
      return user;
    } on DioException catch (e) {
      log("DioException updateProfileData");
      throw ApiExceptions.handelError(e);
    } on ApiErrors catch (e) {
      log("ApiErrors updateProfileData");
      throw ApiErrors(message: e.message);
    } catch (e) {
      log("Catch updateProfileData");
      throw ApiErrors(message: response.toString());
    }
  }

  /// Logout
  Future<void> logout() async {
    final response = await _apiServices.post(ApiConstants.logoutEndPoint, {});
    try {
      await PrefHelper.removeToken();
    } on DioException catch (e) {
      log("DioException logout");
      throw ApiExceptions.handelError(e);
    } on ApiErrors catch (e) {
      log("ApiErrors logout");
      throw ApiErrors(message: e.message);
    } catch (e) {
      log("catch logout");
      throw ApiErrors(message: response.toString());
    }
  }
}
