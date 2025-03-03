import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour/features/auth/auth/data/datasources/auth_local_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/constants/urls.dart';
import '../models/room_type_model.dart';

abstract class RoomRemoteDataSource {
  Future<List<RoomTypeModel>> getRoomTypes(String businessId);
  Future<RoomTypeModel> getRoomTypeDetails(String roomTypeId);
  Future<List<RoomTypeModel>> searchRoomTypes(String query);
}

class RoomRemoteDataSourceImpl implements RoomRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RoomRemoteDataSourceImpl({
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
  Future<List<RoomTypeModel>> getRoomTypes(String businessId) async {
    final headers = await _getAuthHeaders();
    final response = await client.get(
      Uri.parse('${Urls.getRoomTypes}/$businessId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> roomsData = jsonData['data'];
      return roomsData
          .map((roomData) => RoomTypeModel.fromJson(roomData))
          .toList();
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to get room types',
      );
    }
  }

  @override
  Future<RoomTypeModel> getRoomTypeDetails(String roomTypeId) async {
    final headers = await _getAuthHeaders();
    final response = await client.get(
      Uri.parse('${Urls.getRoomTypeDetails}/$roomTypeId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return RoomTypeModel.fromJson(jsonData['data']);
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to get room details',
      );
    }
  }

  @override
  Future<List<RoomTypeModel>> searchRoomTypes(String query) async {
    final headers = await _getAuthHeaders();
    final response = await client.get(
      Uri.parse('${Urls.searchRoomTypes}?query=$query'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> roomsData = jsonData['data'];
      return roomsData
          .map((roomData) => RoomTypeModel.fromJson(roomData))
          .toList();
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to search rooms',
      );
    }
  }
}

