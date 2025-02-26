import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfileEntity>> getCurrentProfile();
  Future<Either<Failure, UserProfileEntity>> updateProfile(UserProfileEntity profile);
  Future<Either<Failure, void>> deleteProfile();
}

