

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../core/constants/urls.dart';
import '../../../auth/auth/data/datasources/auth_local_datasource.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getCurrentProfile();
  Future<UserProfileModel> updateProfile(UserProfileModel profile);
  Future<void> deleteProfile(UserProfileModel profile);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  ProfileRemoteDataSourceImpl({
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
  Future<UserProfileModel> getCurrentProfile() async {
    final headers = await _getAuthHeaders();
    final response = await client.get(
      Uri.parse(Urls.getCurrentProfile),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to get profile',
      );
    }
  }

  @override
  Future<UserProfileModel> updateProfile(UserProfileModel profile) async {
    final headers = await _getAuthHeaders();
    final response = await client.put(
      Uri.parse('${Urls.updateProfile}/${profile.id}'),
      headers: headers,
      body: json.encode(profile.toJson()),
    );

    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to update profile',
      );
    }
  }

  @override
  Future<void> deleteProfile(UserProfileModel profile) async {
    final headers = await _getAuthHeaders();
    final response = await client.delete(
      Uri.parse('${Urls.deleteProfile}/${profile.id}'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to delete profile',
      );
    }
  }
}

