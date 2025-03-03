import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour/core/constants/urls.dart';
import 'package:tour/features/auth/auth/data/datasources/auth_local_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../models/itinerary_model.dart';
import '../models/trip_preferences_model.dart';

abstract class AIPlannerRemoteDataSource {
  Future<ItineraryModel> generateItinerary(TripPreferencesModel preferences);
}

class AIPlannerRemoteDataSourceImpl implements AIPlannerRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;


  AIPlannerRemoteDataSourceImpl({required this.client, required this.authLocalDataSource});

  
   Future<Map<String, String>> _getAuthHeaders() async {
    final token = await authLocalDataSource.getAccessToken();
    if (token == null) {
      throw ServerException(message: 'No access token found');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<ItineraryModel> generateItinerary(TripPreferencesModel preferences) async {
    final headers = await _getAuthHeaders();
    final response = await client.post(
      Uri.parse(Urls.aiPlanner),
      headers: headers,
      body: json.encode(preferences.toJson()),
    );
    print('Request body: $preferences.toJson()');
 print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return ItineraryModel.fromJson(json.decode(response.body)['itinerary']);
    } 
    
    
    else {
      throw ServerException(message: json.decode(response.body)['message'] ?? 'Failed to get profile',);
    }
  }
}

