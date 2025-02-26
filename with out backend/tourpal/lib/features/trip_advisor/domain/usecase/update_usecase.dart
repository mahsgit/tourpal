import 'package:tourpal/features/trip_advisor/domain/entity/trip_entity.dart';
import 'package:tourpal/features/trip_advisor/domain/repository/trip_repo.dart';

class UpdateItinerary {
  final ItineraryRepository repository;

  UpdateItinerary(this.repository);

  Future<Itinerary> call(Itinerary itinerary) {
    return repository.updateItinerary(itinerary);
  }
}