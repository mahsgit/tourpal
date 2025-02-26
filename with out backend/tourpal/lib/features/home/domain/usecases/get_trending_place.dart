import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';
import '../repositories/home_repository.dart';

class GetTrendingPlaces {
  final HomeRepository repository;

  GetTrendingPlaces(this.repository);

  Future<Either<Failure, List<PlaceEntity>>> call() async {
    return await repository.getTrendingPlaces();
  }
}

