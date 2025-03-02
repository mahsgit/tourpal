import 'package:http/http.dart' as http;
import 'package:tour/features/trip_advisor/data/data_source/gemini_datasource.dart';
import 'package:tour/features/trip_advisor/data/data_source/local.dart';
import 'package:tour/features/trip_advisor/domain/entity/trip_entity.dart';
import 'package:tour/features/trip_advisor/domain/entity/trip_preference.dart';
import 'dart:convert';

import 'package:tour/features/trip_advisor/domain/repository/trip_repo.dart';


class ItineraryRepositoryImpl implements ItineraryRepository {
  final GeminiApi geminiApi;
  final LocalStorage localStorage;

  ItineraryRepositoryImpl({
    required this.geminiApi,
    required this.localStorage,
  });

  @override
 Future<Itinerary> generateItinerary(TripPreferences preferences) async {
  final response = await geminiApi.generateItinerary(preferences);
  print('Raw Gemini Response: $response'); // Add this line
  final itinerary = await _processGeminiResponse(response, preferences);
  await localStorage.saveItinerary(itinerary);
  return itinerary;
}

  @override
  Future<Itinerary> updateItinerary(Itinerary itinerary) async {
    await localStorage.saveItinerary(itinerary);
    return itinerary;
  }

  @override
  Future<void> saveItinerary(Itinerary itinerary) {
    return localStorage.saveItinerary(itinerary);
  }

  @override
  Future<List<Itinerary>> getSavedItineraries() {
    return localStorage.getItineraries();
  }
Future<Itinerary> _processGeminiResponse(
  Map<String, dynamic> response,
  TripPreferences preferences,
) async {
  try {
    final List<DayPlan> days = (response['days'] as List).map((dayJson) {
      final activities = (dayJson['activities'] as List).map((activityJson) {
        return Activity(
          id: DateTime.now().toString(), // Generate unique ID
          name: activityJson['name'],
          description: activityJson['description'],
          location: activityJson['location'],
          mapLink: activityJson['mapLink'],
          bookingLink: activityJson['bookingLink'] ?? '',
          price: double.tryParse(activityJson['price'].toString().replaceAll('\$', '')) ?? 0.0,
          startTime: _parseTime(activityJson['startTime']),
          endTime: _parseTime(activityJson['endTime']),
        );
      }).toList();

      return DayPlan(
        id: DateTime.now().toString(), // Generate unique ID
        dayNumber: dayJson['dayNumber'],
        activities: activities,
      );
    }).toList();

    return Itinerary(
      id: DateTime.now().toString(),
      days: days,
      preferences: preferences,
    );
  } catch (e) {
    throw Exception('Failed to parse itinerary: $e');
  }
}

DateTime _parseTime(String timeStr) {
  try {
    final parts = timeStr.split(':');
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  } catch (e) {
    return DateTime.now();
  }
}
// Future<Itinerary> _processGeminiResponse(
//   Map<String, dynamic> response,
//   TripPreferences preferences,
// ) async {
//   try {
//     final generatedContent = response['candidates']?[0]['content']['parts'][0]['text'];
//     if (generatedContent == null) throw Exception('No content in response');

//     // Remove markdown formatting
//     final cleanedContent = generatedContent
//         .replaceAll('```json', '')
//         .replaceAll('```', '')
//         .trim();

//     print('Cleaned Gemini Response: $cleanedContent'); // Debug log

//     final jsonResponse = jsonDecode(cleanedContent);
//     final days = (jsonResponse['days'] as List).map((dayJson) {
//       return DayPlan(
//         id: DateTime.now().microsecondsSinceEpoch.toString(),
//         dayNumber: dayJson['dayNumber'] as int,
//         activities: (dayJson['activities'] as List).map((activityJson) {
//           return Activity(
//             id: DateTime.now().microsecondsSinceEpoch.toString(),
//             name: activityJson['name'] ?? 'Unnamed Activity',
//             description: activityJson['description'] ?? '',
//             location: activityJson['location'] ?? '',
//             mapLink: activityJson['mapLink'] ?? '',
//             bookingLink: activityJson['bookingLink'] ?? '',
//             price: (activityJson['price'] is num) 
//                 ? activityJson['price'].toDouble()
//                 : 0.0,
//             startTime: DateTime.parse(activityJson['startTime']),
//             endTime: DateTime.parse(activityJson['endTime']),
//           );
//         }).toList(),
//       );
//     }).toList();

//     return Itinerary(
//       id: DateTime.now().toIso8601String(),
//       days: days,
//       preferences: preferences,
//     );
//   } catch (e) {
//     print('Error processing Gemini response: $e');
//     throw Exception('Failed to parse itinerary: ${e.toString()}');
//   }
// }



}

