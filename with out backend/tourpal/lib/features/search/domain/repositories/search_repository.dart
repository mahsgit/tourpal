import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/place_entity.dart';

abstract class SearchRepository {
  
  Future<Either<Failure, List<PlaceEntity>>> searchPlaces(String query);
}

