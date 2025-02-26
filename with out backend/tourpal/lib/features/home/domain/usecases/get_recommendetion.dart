import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';
import '../repositories/home_repository.dart';

class GetRecommendedPlaces {
  final HomeRepository repository;

  GetRecommendedPlaces(this.repository);

  Future<Either<Failure, List<PlaceEntity>>> call() async {
    return await repository.getRecommendedPlaces();
  }
}

