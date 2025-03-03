import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/room_type.dart';
import '../../domain/repositories/room_repository.dart';
import '../datasources/room_local_data_source.dart';
import '../datasources/room_remote_data_source.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource remoteDataSource;
  final RoomLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RoomRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<RoomType>>> getRoomTypes(String businessId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRooms = await remoteDataSource.getRoomTypes(businessId);
        await localDataSource.cacheRoomTypes(businessId, remoteRooms);
        return Right(remoteRooms);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final localRooms = await localDataSource.getCachedRoomTypes(businessId);
        return Right(localRooms);
      } on CacheException {
        return Left(CacheFailure('Cache failure occurred'));
      }
    }
  }

  @override
  Future<Either<Failure, RoomType>> getRoomTypeDetails(String roomTypeId) async {
    if (await networkInfo.isConnected) {
      try {
        final room = await remoteDataSource.getRoomTypeDetails(roomTypeId);
        return Right(room);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<RoomType>>> searchRoomTypes(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final rooms = await remoteDataSource.searchRoomTypes(query);
        return Right(rooms);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

