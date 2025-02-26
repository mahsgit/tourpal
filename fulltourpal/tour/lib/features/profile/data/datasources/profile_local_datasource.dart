import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<UserProfileModel> getCachedProfile();
  Future<void> cacheProfile(UserProfileModel profile);
  Future<void> clearProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProfileLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserProfileModel> getCachedProfile() {
    final jsonString = sharedPreferences.getString('CACHED_USER_PROFILE');
    if (jsonString != null) {
      return Future.value(
        UserProfileModel.fromJson(json.decode(jsonString)),
      );
    } else {
      throw CacheException(message: 'No cached profile found');
    }
  }

  @override
  Future<void> cacheProfile(UserProfileModel profile) {
    return sharedPreferences.setString(
      'CACHED_USER_PROFILE',
      json.encode(profile.toJson()),
    );
  }

  @override
  Future<void> clearProfile() {
    return sharedPreferences.remove('CACHED_USER_PROFILE');
  }
}

