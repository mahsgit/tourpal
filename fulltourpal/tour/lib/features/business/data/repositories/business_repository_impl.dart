import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/business_entity.dart';
import '../../domain/repositories/business_repository.dart';
import '../datasources/business_local_datasource.dart';
import '../datasources/business_remote_datasource.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessRemoteDataSource remoteDataSource;
  final BusinessLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BusinessRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<BusinessEntity>>> getBusinesses({
    int page = 1,
    int limit = 10,
    String? query,
    double? minPrice,
    double? maxPrice,
    double? minRating,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final businesses = await remoteDataSource.getBusinesses(
          page: page,
          limit: limit,
        );
        await localDataSource.cacheBusinesses(businesses);
        return Right(businesses);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final localBusinesses = await localDataSource.getCachedBusinesses();
        return Right(localBusinesses);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, BusinessEntity>> getBusinessDetails(
    String businessId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final business = await remoteDataSource.getBusinessDetails(businessId);
        await localDataSource.cacheBusinessDetails(business);
        return Right(business);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final localBusiness =
            await localDataSource.getCachedBusinessDetails(businessId);
        return Right(localBusiness);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}

