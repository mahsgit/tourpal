import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ValidateEmailUseCase implements UseCase<bool, String> {
  final AuthRepository repository;

  ValidateEmailUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String email) async {
    return await repository.validateEmail(email);
  }
}

