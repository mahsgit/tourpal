import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthMessage extends AuthState {
  final String message;

  const AuthMessage({required this.message});

  @override
  List<Object> get props => [message];
}

class EmailValidationState extends AuthState {
  final bool isValid;

  const EmailValidationState({required this.isValid});

  @override
  List<Object> get props => [isValid];
}

