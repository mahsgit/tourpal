import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/constants/urls.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register(String email, String password, String confirmPassword);
  Future<UserModel> login(String email, String password);
  Future<UserModel> googleLogin(String accessToken);
  Future<void> logout();
  Future<void> logoutAll();
  Future<UserModel> refreshToken(String refreshToken);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String token, String newPassword);
  Future<bool> validateEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> register(String email, String password, String confirmPassword) async {
    final response = await client.post(
      Uri.parse(Urls.register),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );
if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true && responseBody['data'] != null) {
        return UserModel.fromJson(responseBody['data']);
      } else {
        throw ServerException(message: responseBody['message'] ?? 'Unknown error occurred');
      }
    } else {
      throw ServerException(message: json.decode(response.body)['message'] ?? 'Server error');
    }
  
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse(Urls.login),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException(message: json.decode(response.body)['message']);
    }
  }

  @override
  Future<UserModel> googleLogin(String accessToken) async {
    final response = await client.post(
      Uri.parse(Urls.googleLogin),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'access_token': accessToken,
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException(message: json.decode(response.body)['message']);
    }
  }

  @override
  Future<void> logout() async {
    final response = await client.post(Uri.parse(Urls.logout));

    if (response.statusCode != 200) {
      throw ServerException(message: json.decode(response.body)['message']);
    }
  }

  @override
  Future<void> logoutAll() async {
    final response = await client.post(Uri.parse(Urls.logoutAll));

    if (response.statusCode != 200) {
      throw ServerException(message: json.decode(response.body)['message']);
    }
  }

  @override
  Future<UserModel> refreshToken(String refreshToken) async {
    final response = await client.post(
      Uri.parse(Urls.refreshToken),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'refreshToken': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException(message: json.decode(response.body)['message']);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    final response = await client.post(
      Uri.parse(Urls.forgotPassword),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(message: json.decode(response.body)['message']);
    }
  }

  @override
  Future<void> resetPassword(String token, String newPassword) async {
    final response = await client.post(
      Uri.parse(Urls.resetPassword),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'token': token,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(message: json.decode(response.body)['message']);
    }
  }

  @override
  Future<bool> validateEmail(String email) async {
    final response = await client.post(
      Uri.parse(Urls.validateEmail),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data']['isValid'];
    } else {
      throw ServerException(message: json.decode(response.body)['message']);
    }
  }
}

