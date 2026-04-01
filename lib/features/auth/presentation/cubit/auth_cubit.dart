import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/errors/api_errors.dart';
import 'package:hungry_app/core/errors/api_exceptions.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:hungry_app/features/auth/data/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoginLoading());
    try {
      final user = await _authRepo.login(email: email, password: password);
      emit(AuthLoginSuccess(user: user!));
    } on ApiErrors catch (e) {
      log("ApiErrors in Login: ${e.message}");
      emit(AuthLoginFailed(message: e.message));
    } on ApiExceptions catch (e) {
      log("Catch Login Cubit: ${e.toString()}");
      emit(AuthLoginFailed(message: e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthSignUpLoading());
    try {
      final user = await _authRepo.signUp(
        name: name,
        email: email,
        password: password,
      );
      emit(AuthSignUpSuccess(user: user!));
    } on ApiErrors catch (e) {
      log("ApiErrors in SignUp: ${e.message}");
      emit(AuthSignUpFailed(message: e.message));
    } catch (e) {
      log("Catch SignUp Cubit: ${e.toString()}");
      emit(AuthSignUpFailed(message: e.toString()));
    }
  }

  Future<void> getProfileData() async {
    try {
      emit(GetProfileDataLoading());
      final user = await _authRepo.getProfileData();
      emit(GetProfileDataSuccess(user: user!));
    } on ApiErrors catch (e) {
      log("ApiErrors in Profile: ${e.message}");
      emit(GetProfileDataFailed(message: e.message));
    } catch (e) {
      log("Catch Profile Cubit: ${e.toString()}");
      emit(GetProfileDataFailed(message: e.toString()));
    }
  }

  Future<void> updateProfileData({
    required String name,
    required String email,
    required String phone,
    required String? image,
    required String address,
    required String? visa,
  }) async {
    try {
      emit(UpdateProfileDataLoading());
      await _authRepo.updateProfileData(
        name: name,
        email: email,
        phone: phone,
        image: image,
        address: address,
        visa: visa,
      );
      await getProfileData();
      emit(UpdateProfileDataSuccess());
    } on ApiErrors catch (e) {
      log("ApiErrors in Update Profile: ${e.message}");
      emit(UpdateProfileDataFailed(message: e.message));
    } catch (e) {
      log("Catch Update Profile Cubit: ${e.toString()}");
      emit(UpdateProfileDataFailed(message: e.toString()));
    }
  }
}
