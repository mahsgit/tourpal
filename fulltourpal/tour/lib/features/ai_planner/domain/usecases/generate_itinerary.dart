import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/itinerary.dart';
import '../entities/trip_preferences.dart';
import '../repositories/ai_planner_repository.dart';

class GenerateItinerary implements UseCase<Itinerary, TripPreferences> {
  final AIPlannerRepository repository;

  GenerateItinerary(this.repository);

  @override
  Future<Either<Failure, Itinerary>> call(TripPreferences params) async {
    return await repository.generateItinerary(params);
  }
}

