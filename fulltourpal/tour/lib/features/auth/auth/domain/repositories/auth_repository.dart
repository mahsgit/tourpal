import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register(String email, String password, String confirmPassword);
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> googleLogin(String accessToken);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> logoutAll();
  Future<Either<Failure, User>> refreshToken(String refreshToken);
  Future<Either<Failure, void>> forgotPassword(String email);
  Future<Either<Failure, void>> resetPassword(String token, String newPassword);
  Future<Either<Failure, bool>> validateEmail(String email);
}

