import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour/features/auth/auth/data/datasources/auth_local_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/constants/urls.dart';
import '../models/business_model.dart';

abstract class BusinessRemoteDataSource {
  Future<List<BusinessModel>> getBusinesses({int page = 1, int limit = 10});
  Future<BusinessModel> getBusinessDetails(String businessId);
}

class BusinessRemoteDataSourceImpl implements BusinessRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  BusinessRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  Future<Map<String, String>> _getHeaders() async {
    final token = await authLocalDataSource.getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<List<BusinessModel>> getBusinesses({int page = 1, int limit = 10}) async {
    final headers = await _getHeaders();
    final response = await client.get(
      Uri.parse('${Urls.businesses}?page=$page&limit=$limit'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final businessesData = jsonData['data']['businesses'] as List;
      return businessesData
          .map((business) => BusinessModel.fromJson(business))
          .toList();
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to load businesses',
      );
    }
  }

  @override
  Future<BusinessModel> getBusinessDetails(String businessId) async {
    final headers = await _getHeaders();
    final response = await client.get(
      Uri.parse('${Urls.businesses}/$businessId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return BusinessModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException(
        message: json.decode(response.body)['message'] ?? 'Failed to load business details',
      );
    }
  }
}

