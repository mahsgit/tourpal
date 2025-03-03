import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/user_profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserProfileEntity>> getCurrentProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await remoteDataSource.getCurrentProfile();
        localDataSource.cacheProfile(remoteProfile);
        return Right(remoteProfile);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final localProfile = await localDataSource.getCachedProfile();
        return Right(localProfile);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
@override
Future<Either<Failure, UserProfileEntity>> updateProfile(
  UserProfileEntity profile,
) async {
  if (await networkInfo.isConnected) {
    try {
      // Convert entity to model properly
      final updatedProfile = await remoteDataSource.updateProfile(
        profile.toModel()  // Use conversion method instead of cast
      );
      localDataSource.cacheProfile(updatedProfile);
      return Right(updatedProfile.toEntity());  // Convert back to entity if needed
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  } else {
    return Left(NetworkFailure());
  }
}

@override
Future<Either<Failure, void>> deleteProfile(UserProfileEntity profile) async {
  if (await networkInfo.isConnected) {
    try {
      // Convert entity to model properly
      await remoteDataSource.deleteProfile(profile.toModel());
      await localDataSource.clearProfile();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  } else {
    return Left(NetworkFailure());
  }
}
}
