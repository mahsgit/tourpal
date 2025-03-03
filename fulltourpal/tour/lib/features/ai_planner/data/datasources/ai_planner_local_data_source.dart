import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/itinerary_model.dart';

abstract class AIPlannerLocalDataSource {
  Future<ItineraryModel?> getLastItinerary();
  Future<void> cacheItinerary(ItineraryModel itinerary);
}

class AIPlannerLocalDataSourceImpl implements AIPlannerLocalDataSource {
  final SharedPreferences sharedPreferences;

  AIPlannerLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ItineraryModel?> getLastItinerary() async {
    final jsonString = sharedPreferences.getString('CACHED_ITINERARY');
    if (jsonString != null) {
      return ItineraryModel.fromJson(json.decode(jsonString));
    }
    return null;
  }

  @override
  Future<void> cacheItinerary(ItineraryModel itinerary) {
    return sharedPreferences.setString(
      'CACHED_ITINERARY',
      json.encode(itinerary.toJson()),
    );
  }
}

