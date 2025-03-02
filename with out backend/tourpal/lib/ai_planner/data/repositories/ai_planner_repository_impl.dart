import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/itinerary.dart';
import '../../domain/entities/trip_preferences.dart';
import '../../domain/repositories/ai_planner_repository.dart';
import '../datasources/ai_planner_local_data_source.dart';
import '../datasources/ai_planner_remote_data_source.dart';
import '../models/trip_preferences_model.dart';

class AIPlannerRepositoryImpl implements AIPlannerRepository {
  final AIPlannerRemoteDataSource remoteDataSource;
  final AIPlannerLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AIPlannerRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Itinerary>> generateItinerary(TripPreferences preferences) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteItinerary = await remoteDataSource.generateItinerary(
          TripPreferencesModel(
            destination: preferences.destination,
            startDate: preferences.startDate,
            endDate: preferences.endDate,
            travelType: preferences.travelType,
            preferences: preferences.preferences,
          ),
        );
        localDataSource.cacheItinerary(remoteItinerary);
        return Right(remoteItinerary);
      } on ServerException {
        return Left(ServerFailure('Server error occurred'));
      }
    } else {
      try {
        final localItinerary = await localDataSource.getLastItinerary();
        return Right(localItinerary!);
      } on CacheException {
        return Left(CacheFailure('Cache error occurred'));
      }
    }
  }
}

