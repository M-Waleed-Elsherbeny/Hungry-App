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
