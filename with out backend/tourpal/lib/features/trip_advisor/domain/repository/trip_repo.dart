import 'package:tourpal/features/trip_advisor/domain/entity/trip_entity.dart';
import 'package:tourpal/features/trip_advisor/domain/entity/trip_preference.dart';


abstract class ItineraryRepository {
  Future<Itinerary> generateItinerary(TripPreferences preferences);
  Future<Itinerary> updateItinerary(Itinerary itinerary);
  Future<void> saveItinerary(Itinerary itinerary);
  Future<List<Itinerary>> getSavedItineraries();
}

