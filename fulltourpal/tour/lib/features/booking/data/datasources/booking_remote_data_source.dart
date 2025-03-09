import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour/features/auth/auth/data/datasources/auth_local_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/constants/urls.dart';
import '../models/availability_model.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<AvailabilityModel>> getAvailableTimeRanges({
    required String businessId,
    required String roomTypeId,
  });
  
  Future<List<String>> getAvailableRoomTypes({
    required String businessId,
    required DateTime startDate,
    required DateTime endDate,
  });
  
  Future<BookingModel> reserveBooking(BookingModel booking);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  BookingRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

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
  Future<List<AvailabilityModel>> getAvailableTimeRanges({
    required String businessId,
    required String roomTypeId,
  }) async {
    final headers = await _getAuthHeaders();
    final response = await client.get(
      Uri.parse('${Urls.availableTimeRanges}?businessId=$businessId&roomTypeId=$roomTypeId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> availabilityData = jsonData['data'];
      return availabilityData
          .map((data) => AvailabilityModel.fromJson(data))
          .toList();
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to get available time ranges',
      );
    }
  }

  @override
  Future<List<String>> getAvailableRoomTypes({
    required String businessId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final headers = await _getAuthHeaders();
    final response = await client.get(
      Uri.parse(
        '${Urls.availableRoomTypes}?businessId=$businessId&startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> roomTypesData = jsonData['data'];
      return roomTypesData.map((data) => data.toString()).toList();
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to get available room types',
      );
    }
  }

  @override
  Future<BookingModel> reserveBooking(BookingModel booking) async {
    final headers = await _getAuthHeaders();
    final response = await client.post(
      Uri.parse(Urls.reserveBooking),
      headers: headers,
      body: json.encode(booking.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return BookingModel.fromJson(jsonData['data']);
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to reserve booking',
      );
    }
  }
}

