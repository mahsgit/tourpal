

import 'package:http/http.dart' as http;
import 'package:tour/features/trip_advisor/domain/entity/trip_preference.dart';
import 'dart:convert';

class GeminiApi {
  final String apiKey;
  final String baseUrl;

  GeminiApi({
    required this.apiKey,
    this.baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyCJJDJnHk6kPtYs1pT6WKqLF37AS0nM9LE',
  });

  Future<Map<String, dynamic>> generateItinerary(TripPreferences preferences) async {
    final prompt = _createPrompt(preferences);
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        
        // Extract the text content from Gemini's response structure
        final candidates = responseBody['candidates'] as List;
        if (candidates.isNotEmpty) {
          final content = candidates[0]['content']['parts'][0]['text'] as String;
          
          // Find the JSON object within the response text
          final jsonStart = content.indexOf('{');
          final jsonEnd = content.lastIndexOf('}') + 1;
          
          if (jsonStart >= 0 && jsonEnd > jsonStart) {
            final jsonString = content.substring(jsonStart, jsonEnd);
            return jsonDecode(jsonString);
          }
        }
        throw Exception('No valid JSON found in response');
      } else {
        throw Exception('API request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to generate itinerary: $e');
    }
  }

  String _createPrompt(TripPreferences preferences) {
    return '''
    Generate a travel itinerary in the following JSON format only. Do not include any additional text or explanations:
    {
      "days": [
        {
          "dayNumber": 1,
          "activities": [
            {
              "name": "Activity name",
              "description": "Detailed description",
              "location": "Address",
              "mapLink": "Google Maps URL",
              "bookingLink": "Booking URL if applicable",
              "price": "Estimated price",
              "startTime": "Start time in HH:mm format",
              "endTime": "End time in HH:mm format"
            }
          ]
        }
      ]
    }

    Use these preferences:
    Location: ${preferences.location}
    Date: ${preferences.date}
    Time: ${preferences.time}
    Traveler Type: ${preferences.travelerType}
    Budget: \$${preferences.budget}
    Place Types: ${preferences.placeTypes.join(', ')}
    Activities: ${preferences.activities.join(', ')}
    Number of People: ${preferences.numberOfPeople}
    ''';
  }
}