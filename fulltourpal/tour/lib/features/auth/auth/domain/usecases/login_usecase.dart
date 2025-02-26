// import 'package:dartz/dartz.dart';
// import '../../../../core/error/failures.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../entities/user_entity.dart';
// import '../repositories/auth_repository.dart';

// class LoginParams {
//   final String email;
//   final String password;

//   LoginParams({required this.email, required this.password});
// }

// class LoginUseCase implements UseCase<UserEntity, LoginParams> {
//   final AuthRepository repository;

//   LoginUseCase(this.repository);

//   @override
//   Future<Either<Failure, UserEntity>> call(LoginParams params) async {
//     return await repository.login(params.email, params.password);
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:tour/features/auth/auth/domain/entities/user.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    final result = await repository.login(params.email, params.password);
    return result.map((user) => User.fromUser(user));
  }
}