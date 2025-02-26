import 'package:dartz/dartz.dart';
import 'package:tourpal/features/hotel/domain/repositories/hotel_repo.dart';
import '../../../../core/errors/failures.dart';
import '../entities/hotel_entity.dart';

class GetHotels {
  final HotelRepository repository;

  GetHotels(this.repository);

  Future<Either<Failure, List<HotelEntity>>> call() async {
    return await repository.getHotels();
  }
}

