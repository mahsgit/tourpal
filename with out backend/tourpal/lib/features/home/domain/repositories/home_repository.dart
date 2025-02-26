import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';
import '../entities/category_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<PlaceEntity>>> getTrendingPlaces();
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<PlaceEntity>>> getRecommendedPlaces();
  // Future<Either<Failure, List<PlaceEntity>>> searchPlaces(String query);
}

