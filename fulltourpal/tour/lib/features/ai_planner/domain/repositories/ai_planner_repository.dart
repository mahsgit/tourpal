import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/itinerary.dart';
import '../entities/trip_preferences.dart';

abstract class AIPlannerRepository {
  Future<Either<Failure, Itinerary>> generateItinerary(TripPreferences preferences);
}

