import 'package:dartz/dartz.dart';
import 'package:tourpal/features/hotel/domain/repositories/hotel_repo.dart';
import '../../../../core/errors/failures.dart';
import '../entities/hotel_entity.dart';

class GetHotelDetails {
  final HotelRepository repository;

  GetHotelDetails(this.repository);

  Future<Either<Failure, HotelEntity>> call(String id) async {
    return await repository.getHotelDetails(id);
  }
}

