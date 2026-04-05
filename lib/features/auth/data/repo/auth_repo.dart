import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/constants/api_constant.dart';
import 'package:hungry_app/core/errors/failure.dart';
import 'package:hungry_app/core/networking/api_services.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';

class AuthRepo {
  final ApiServices _apiServices = ApiServices();

  /// Login
  Future<Either<Failure, UserModel?>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiServices.post(
        endPoint: ApiConstants.loginEndPoint,
        data: {"email": email, "password": password},
      );
      final UserModel user = UserModel.fromJson(response["data"]);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return Right(user);
    } on DioException catch (error) {
      log("DioException Login: $error");
      return Left(ServerFailure.fromDioException(error));
    } catch (e) {
      log("Catch Login: $e");
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  /// Sign Up
  Future<Either<Failure, UserModel?>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiServices.post(
        endPoint: ApiConstants.signUpEndPoint,
        data: {"name": name, "email": email, "password": password},
      );
      final UserModel user = UserModel.fromJson(response["data"]);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return Right(user);
    } on DioException catch (error) {
      log("DioException SignUp: $error");

      return Left(ServerFailure.fromDioException(error));
    } catch (e) {
      log("Catch SignUp: $e");
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  /// Profile
  Future<Either<Failure, UserModel?>> getProfileData() async {
    try {
      final response = await _apiServices.get(
        endPoint: ApiConstants.profileEndPoint,
      );
      final UserModel user = UserModel.fromJson(response["data"]);
      return Right(user);
    } on DioException catch (error) {
      log("DioException getProfileData: $error");
      return Left(ServerFailure.fromDioException(error));
    } catch (e) {
      log("Catch getProfileData: $e");
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  /// Update Profile
  Future<Either<Failure, UserModel?>> updateProfileData({
    required String name,
    required String email,
    required String phone,
    required String? image,
    required String address,
    required String? visa,
  }) async {
    try {
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
        endPoint: ApiConstants.updateProfileEndPoint,
        data: formData,
      );
      final UserModel user = UserModel.fromJson(response["data"]);
      return Right(user);
    } on DioException catch (error) {
      log("DioException updateProfileData: $error");
      return Left(ServerFailure.fromDioException(error));
    } catch (e) {
      log("Catch updateProfileData: $e");
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  /// Logout
  Future<Either<Failure, void>> logout() async {
    try {
      await _apiServices.post(endPoint: ApiConstants.logoutEndPoint);
      await PrefHelper.removeToken();
      return const Right(null);
    } on DioException catch (error) {
      log("DioException SignUp: $error");
      return Left(ServerFailure.fromDioException(error));
    } catch (e) {
      log("Catch SignUp: $e");
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
