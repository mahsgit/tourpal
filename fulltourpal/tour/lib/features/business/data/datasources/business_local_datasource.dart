import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/business_model.dart';

abstract class BusinessLocalDataSource {
  Future<List<BusinessModel>> getCachedBusinesses();
  Future<BusinessModel> getCachedBusinessDetails(String businessId);
  Future<void> cacheBusinesses(List<BusinessModel> businesses);
  Future<void> cacheBusinessDetails(BusinessModel business);
}

class BusinessLocalDataSourceImpl implements BusinessLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String CACHED_BUSINESSES_KEY = 'CACHED_BUSINESSES';
  static const String CACHED_BUSINESS_DETAILS_PREFIX = 'CACHED_BUSINESS_DETAILS_';

  BusinessLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<BusinessModel>> getCachedBusinesses() async {
    final jsonString = sharedPreferences.getString(CACHED_BUSINESSES_KEY);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => BusinessModel.fromJson(json)).toList();
    } else {
      throw CacheException(message: 'No cached businesses found');
    }
  }

  @override
  Future<BusinessModel> getCachedBusinessDetails(String businessId) async {
    final jsonString = sharedPreferences.getString(
      CACHED_BUSINESS_DETAILS_PREFIX + businessId,
    );
    if (jsonString != null) {
      return BusinessModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(message: 'No cached business details found');
    }
  }

  @override
  Future<void> cacheBusinesses(List<BusinessModel> businesses) async {
    final List<Map<String, dynamic>> jsonList = businesses
        .map((business) => (business as BusinessModel).toJson())
        .toList();
    await sharedPreferences.setString(
      CACHED_BUSINESSES_KEY,
      json.encode(jsonList),
    );
  }

  @override
  Future<void> cacheBusinessDetails(BusinessModel business) async {
    await sharedPreferences.setString(
      CACHED_BUSINESS_DETAILS_PREFIX + business.id,
      json.encode(business.toJson()),
    );
  }
}

