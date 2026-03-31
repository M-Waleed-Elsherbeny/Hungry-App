import 'dart:developer';
import 'package:hungry_app/core/constants/api_constant.dart';
import 'package:hungry_app/core/errors/api_errors.dart';
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
      return user;
    } catch (e) {
      log("Catch Get Profile Data $e");
      throw ApiErrors(message: response.toString());
    }
  }
}
