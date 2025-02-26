import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/place_entity.dart';
import '../repositories/search_repository.dart';

class SearchPlaces {
  final SearchRepository repository;

  SearchPlaces(this.repository);

  Future<Either<Failure, List<PlaceEntity>>> call(String query) async {
    return await repository.searchPlaces(query);
  }
}

