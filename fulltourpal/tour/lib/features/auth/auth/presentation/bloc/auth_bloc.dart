import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/google_login.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/refresh_token.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/validate_email.dart';
import '../../../../../core/usecases/usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GoogleLoginUseCase googleLoginUseCase;
  final LogoutUseCase logoutUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final ValidateEmailUseCase validateEmailUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.googleLoginUseCase,
    required this.logoutUseCase,
    required this.refreshTokenUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.validateEmailUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUseCase(LoginParams(
        email: event.email,
        password: event.password,
      ));
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(AuthAuthenticated(user: user)),
      );
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await registerUseCase(RegisterParams(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      ));
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(AuthAuthenticated(user: user)),
      );
    });

    on<GoogleLoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await googleLoginUseCase(event.accessToken);
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(AuthAuthenticated(user: user)),
      );
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await logoutUseCase(NoParams());
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (_) => emit(AuthInitial()),
      );
    });

    on<RefreshTokenRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await refreshTokenUseCase(event.refreshToken);
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(AuthAuthenticated(user: user)),
      );
    });

    on<ForgotPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await forgotPasswordUseCase(event.email);
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (_) => emit(const AuthMessage(message: 'Password reset email sent')),
      );
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await resetPasswordUseCase(ResetPasswordParams(
        token: event.token,
        newPassword: event.newPassword,
      ));
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (_) => emit(const AuthMessage(message: 'Password reset successfully')),
      );
    });

    on<ValidateEmailRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await validateEmailUseCase(event.email);
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (isValid) => emit(EmailValidationState(isValid: isValid)),
      );
    });
  }
}

