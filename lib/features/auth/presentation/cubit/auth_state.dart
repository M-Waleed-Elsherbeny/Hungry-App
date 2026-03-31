import 'package:hungry_app/features/auth/data/models/user_model.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final UserModel user;
  AuthLoginSuccess({required this.user});
}

final class AuthLoginFailed extends AuthState {
  final String message;

  AuthLoginFailed({required this.message});
}

final class AuthSignUpLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {
  final UserModel user;
  AuthSignUpSuccess({required this.user});
}

final class AuthSignUpFailed extends AuthState {
  final String message;

  AuthSignUpFailed({required this.message});
}
final class GetProfileDataLoading extends AuthState {}

final class GetProfileDataSuccess extends AuthState {
  final UserModel user;
  GetProfileDataSuccess({required this.user});
}

final class GetProfileDataFailed extends AuthState {
  final String message;

  GetProfileDataFailed({required this.message});
}
