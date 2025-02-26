import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterRequested({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, password, confirmPassword];
}

class GoogleLoginRequested extends AuthEvent {
  final String accessToken;

  const GoogleLoginRequested({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}

class LogoutRequested extends AuthEvent {}

class RefreshTokenRequested extends AuthEvent {
  final String refreshToken;

  const RefreshTokenRequested({required this.refreshToken});

  @override
  List<Object> get props => [refreshToken];
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetPasswordRequested extends AuthEvent {
  final String token;
  final String newPassword;

  const ResetPasswordRequested({required this.token, required this.newPassword});

  @override
  List<Object> get props => [token, newPassword];
}

class ValidateEmailRequested extends AuthEvent {
  final String email;

  const ValidateEmailRequested({required this.email});

  @override
  List<Object> get props => [email];
}

