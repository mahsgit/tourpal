import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetCurrentProfile implements UseCase<UserProfileEntity, NoParams> {
  final ProfileRepository repository;

  GetCurrentProfile(this.repository);

  @override
  Future<Either<Failure, UserProfileEntity>> call(NoParams params) async {
    return await repository.getCurrentProfile();
  }
}

