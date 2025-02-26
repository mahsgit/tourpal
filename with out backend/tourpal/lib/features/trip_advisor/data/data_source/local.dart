// import 'package:tourpal/features/trip_advisor/domain/entity/trip_entity.dart';

// abstract class LocalStorage {
//   Future<void> saveItinerary(Itinerary itinerary);
//   Future<List<Itinerary>> getItineraries();
// }

// class LocalStorageImpl implements LocalStorage {
//   @override
//   Future<void> saveItinerary(Itinerary itinerary) async {
//     // Implementation to save itinerary
//     // For now, we'll just print a message
//     print('Saving itinerary: ${itinerary.id}');
//   }

//   @override
//   Future<List<Itinerary>> getItineraries() async {
//     // Implementation to get saved itineraries
//     // For now, we'll return an empty list
//     return [];
//   }
// }

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourpal/features/trip_advisor/domain/entity/trip_entity.dart';
import 'package:tourpal/features/trip_advisor/domain/entity/trip_preference.dart';

abstract class LocalStorage {
  Future<void> saveItinerary(Itinerary itinerary);
  Future<List<Itinerary>> getItineraries();
  Future<void> updateItinerary(Itinerary itinerary);
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences prefs;
  static const String _itinerariesKey = 'saved_itineraries';

  LocalStorageImpl({required this.prefs});

  @override
  Future<void> saveItinerary(Itinerary itinerary) async {
    final List<String> savedItineraries = prefs.getStringList(_itinerariesKey) ?? [];
    savedItineraries.add(_itineraryToJson(itinerary));
    await prefs.setStringList(_itinerariesKey, savedItineraries);
    print('Saving itinerary: ${itinerary.id}');
  }

  @override
  Future<List<Itinerary>> getItineraries() async {
    final List<String> savedItineraries = prefs.getStringList(_itinerariesKey) ?? [];
    return savedItineraries.map((json) => _itineraryFromJson(json)).toList();
  }

  @override
  Future<void> updateItinerary(Itinerary itinerary) async {
    final List<String> savedItineraries = prefs.getStringList(_itinerariesKey) ?? [];
    final List<Itinerary> itineraries = savedItineraries.map((json) => _itineraryFromJson(json)).toList();
    
    final index = itineraries.indexWhere((item) => item.id == itinerary.id);
    if (index != -1) {
      itineraries[index] = itinerary;
      final updatedJson = itineraries.map((item) => _itineraryToJson(item)).toList();
      await prefs.setStringList(_itinerariesKey, updatedJson);
      print('Updating itinerary: ${itinerary.id}');
    }
  }

  String _itineraryToJson(Itinerary itinerary) {
    return jsonEncode({
      'id': itinerary.id,
      'days': itinerary.days.map((day) => {
        'id': day.id,
        'dayNumber': day.dayNumber,
        'activities': day.activities.map((activity) => {
          'id': activity.id,
          'name': activity.name,
          'description': activity.description,
          'location': activity.location,
          'mapLink': activity.mapLink,
          'bookingLink': activity.bookingLink,
          'price': activity.price,
          'startTime': activity.startTime.toIso8601String(),
          'endTime': activity.endTime.toIso8601String(),
        }).toList(),
      }).toList(),
      'preferences': {
        'location': itinerary.preferences.location,
        'date': itinerary.preferences.date.toIso8601String(),
        'time': itinerary.preferences.time,
        'travelerType': itinerary.preferences.travelerType,
        'budget': itinerary.preferences.budget,
        'placeTypes': itinerary.preferences.placeTypes,
        'activities': itinerary.preferences.activities,
        'numberOfPeople': itinerary.preferences.numberOfPeople,
      },
    });
  }

  Itinerary _itineraryFromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    
    return Itinerary(
      id: json['id'],
      days: (json['days'] as List).map((dayJson) => DayPlan(
        id: dayJson['id'],
        dayNumber: dayJson['dayNumber'],
        activities: (dayJson['activities'] as List).map((activityJson) => Activity(
          id: activityJson['id'],
          name: activityJson['name'],
          description: activityJson['description'],
          location: activityJson['location'],
          mapLink: activityJson['mapLink'],
          bookingLink: activityJson['bookingLink'],
          price: activityJson['price'],
          startTime: DateTime.parse(activityJson['startTime']),
          endTime: DateTime.parse(activityJson['endTime']),
        )).toList(),
      )).toList(),
      preferences: TripPreferences(
        location: json['preferences']['location'],
        date: DateTime.parse(json['preferences']['date']),
        time: json['preferences']['time'],
        travelerType: json['preferences']['travelerType'],
        budget: json['preferences']['budget'],
        placeTypes: List<String>.from(json['preferences']['placeTypes']),
        activities: List<String>.from(json['preferences']['activities']),
        numberOfPeople: json['preferences']['numberOfPeople'],
      ),
    );
  }
}