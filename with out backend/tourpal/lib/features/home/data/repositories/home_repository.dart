import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/place_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<PlaceEntity>>> getTrendingPlaces() async {
    try {
      final places = await localDataSource.getTrendingPlaces();
      return Right(places);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await localDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> getRecommendedPlaces() async {
    try {
      final places = await localDataSource.getRecommendedPlaces();
      return Right(places);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, List<PlaceEntity>>> searchPlaces(String query) async {
  //   try {
  //     final places = await localDataSource.searchPlaces(query);
  //     return Right(places);
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }
}

