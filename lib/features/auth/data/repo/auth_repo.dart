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
    } catch (_) {
      log("Catch Login");
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
    } catch (_) {
      log("Catch Sign Up");
      throw ApiErrors(message: response.toString());
    }
  }

  /// Profile
  Future<UserModel?> getProfileData() async {
    final response = await _apiServices.get(ApiConstants.profileEndPoint);
    try {
      UserModel user = UserModel.fromJson(response["data"]);
      log(user.toString());
      return user;
    } catch (e) {
      log("Catch Get Profile Data $e");
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
    } catch (_) {
      log("Catch updateProfileData");
      throw ApiErrors(message: response.toString());
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      final response = await _apiServices.post(ApiConstants.logoutEndPoint, {});
      log(response.toString());
      await PrefHelper.removeToken();
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    } on ApiErrors catch (e) {
      throw ApiErrors(message: e.message);
    } catch (e) {
      ApiErrors(message: e.toString());
    }
  }
}
