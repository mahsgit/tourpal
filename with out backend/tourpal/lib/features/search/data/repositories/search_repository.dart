import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/place_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_local_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource localDataSource;

  SearchRepositoryImpl(this.localDataSource);

  
  @override
  Future<Either<Failure, List<PlaceEntity>>> searchPlaces(String query) async {
    try {
      final places = await localDataSource.searchPlaces(query);
      return Right(places);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

