import 'package:dartz/dartz.dart';
import 'package:tourpal/features/hotel/data/datasources/hotel_local_datasource.dart';
import 'package:tourpal/features/hotel/domain/repositories/hotel_repo.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/hotel_entity.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelLocalDataSource localDataSource;

  HotelRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<HotelEntity>>> getHotels() async {
    try {
      final hotels = await localDataSource.getHotels();
      return Right(hotels);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HotelEntity>> getHotelDetails(String id) async {
    try {
      final hotel = await localDataSource.getHotelDetails(id);
      return Right(hotel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String id) async {
    try {
      await localDataSource.toggleFavorite(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

