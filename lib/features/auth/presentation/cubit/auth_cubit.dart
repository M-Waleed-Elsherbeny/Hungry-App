import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:hungry_app/features/auth/data/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoginLoading());
    final response = await _authRepo.login(email: email, password: password);
    response.fold(
      ifLeft: (error) => emit(AuthLoginFailed(message: error.errMessage)),
      ifRight: (user) => emit(AuthLoginSuccess(user: user!)),
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthSignUpLoading());

    final response = await _authRepo.signUp(
      name: name,
      email: email,
      password: password,
    );
    response.fold(
      ifLeft: (error) => emit(AuthSignUpFailed(message: error.errMessage)),
      ifRight: (user) => emit(AuthSignUpSuccess(user: user!)),
    );
  }

  Future<void> getProfileData() async {
    emit(GetProfileDataLoading());
    final response = await _authRepo.getProfileData();
    response.fold(
      ifLeft: (error) => emit(GetProfileDataFailed(message: error.errMessage)),
      ifRight: (user) => emit(GetProfileDataSuccess(user: user!)),
    );
  }

  Future<void> updateProfileData({
    required String name,
    required String email,
    required String phone,
    required String? image,
    required String address,
    required String? visa,
  }) async {
    emit(UpdateProfileDataLoading());
    final response = await _authRepo.updateProfileData(
      name: name,
      email: email,
      phone: phone,
      image: image,
      address: address,
      visa: visa,
    );
    response.fold(
      ifLeft: (error) =>
          emit(UpdateProfileDataFailed(message: error.errMessage)),
      ifRight: (user) => emit(UpdateProfileDataSuccess(user: user!)),
    );
  }

  Future<void> logout() async {
      emit(AuthLogoutLoading());
      final response = await _authRepo.logout();
      response.fold(
      ifLeft: (error) => emit(AuthLogoutFailed(message: error.errMessage)),
      ifRight: (_) => emit(AuthLogoutSuccess()),
    );
  }
}
