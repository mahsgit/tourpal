// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../core/error/exceptions.dart';
// import '../models/user_model.dart';

// abstract class AuthLocalDataSource {
//   Future<void> cacheUser(UserModel user);
//   Future<UserModel> getLastUser();
//   Future<void> removeUser();
// }

// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
//   final SharedPreferences sharedPreferences;

//   AuthLocalDataSourceImpl({required this.sharedPreferences});

//   // @override
//   // Future<void> cacheUser(UserModel user) {
//   //   return sharedPreferences.setString(
//   //     'CACHED_USER',
//   //     json.encode(user.toJson()),
//   //   );
//   // }

//   @override
// Future<void> cacheUser(UserModel user) async {
//   final jsonString = json.encode(user.toJson());
//   await sharedPreferences.setString('CACHED_USER', jsonString);
// }

//   @override
//   Future<UserModel> getLastUser() {
//     final jsonString = sharedPreferences.getString('CACHED_USER');
//     if (jsonString != null) {
//       return Future.value(UserModel.fromJson(json.decode(jsonString)));
//     } else {
//       throw CacheException(message: 'No cached user found');
//     }
//   }

//   @override
//   Future<void> removeUser() {
//     return sharedPreferences.remove('CACHED_USER');
//   }
// }

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour/core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel> getLastUser();
  Future<void> removeUser();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String CACHED_USER_KEY = 'CACHED_USER';
  static const String ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
  static const String REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(
      CACHED_USER_KEY,
      json.encode(user.toJson()),
    );
    
    if (user.accessToken != null) {
      await sharedPreferences.setString(ACCESS_TOKEN_KEY, user.accessToken!);
    }
    
    if (user.refreshToken != null) {
      await sharedPreferences.setString(REFRESH_TOKEN_KEY, user.refreshToken!);
    }
  }

  @override
  Future<UserModel> getLastUser() {
    final jsonString = sharedPreferences.getString(CACHED_USER_KEY);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException(message: 'No cached user found');
    }
  }

  @override
  Future<void> removeUser() async {
    await sharedPreferences.remove(CACHED_USER_KEY);
    await sharedPreferences.remove(ACCESS_TOKEN_KEY);
    await sharedPreferences.remove(REFRESH_TOKEN_KEY);
  }

  @override
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString(ACCESS_TOKEN_KEY);
  }

  @override
  Future<String?> getRefreshToken() async {
    return sharedPreferences.getString(REFRESH_TOKEN_KEY);
  }
}

