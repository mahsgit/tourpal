import 'package:tour/features/trip_advisor/domain/entity/trip_entity.dart';
import 'package:tour/features/trip_advisor/domain/entity/trip_preference.dart';
import 'package:tour/features/trip_advisor/domain/repository/trip_repo.dart';

class GenerateItinerary {
  final ItineraryRepository repository;

  GenerateItinerary(this.repository);

  Future<Itinerary> call(TripPreferences preferences) {
    return repository.generateItinerary(preferences);
  }
}

