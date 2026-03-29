import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/networking/api_errors.dart';
import 'package:hungry_app/core/networking/api_exceptions.dart';
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
      log("ApiErrors: ${e.message}");
      emit(AuthLoginFailed(message: e.message));
    } on ApiExceptions catch (e) {
      log("ApiExceptions: ${e.toString()}");
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
      emit(AuthLoginSuccess(user: user!));
    } on ApiErrors catch (e) {
      log("ApiErrors: ${e.message}");
      emit(AuthSignUpFailed(message: e.message));
    } catch (e) {
      log("ApiExceptions: ${e.toString()}");
      emit(AuthSignUpFailed(message: e.toString()));
    }
  }
}
