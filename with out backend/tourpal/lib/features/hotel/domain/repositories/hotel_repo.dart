import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/hotel_entity.dart';

abstract class HotelRepository {
  Future<Either<Failure, List<HotelEntity>>> getHotels();
  Future<Either<Failure, HotelEntity>> getHotelDetails(String id);
  Future<Either<Failure, void>> toggleFavorite(String id);
}

