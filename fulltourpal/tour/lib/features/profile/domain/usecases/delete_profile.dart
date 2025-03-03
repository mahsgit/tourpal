import 'package:dartz/dartz.dart';
import 'package:tour/features/profile/domain/entities/user_profile_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class DeleteProfile implements UseCase<void, UserProfileEntity> {
  final ProfileRepository repository;

  DeleteProfile(this.repository);

  @override
  Future<Either<Failure, void>> call(UserProfileEntity profile) async {
    return await repository.deleteProfile(profile);
  }
}

