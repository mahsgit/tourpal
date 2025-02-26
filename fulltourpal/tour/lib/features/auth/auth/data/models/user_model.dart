import 'dart:convert';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String email,
    required String accessToken,
    String? refreshToken,
    bool isEmailVerified = false,
    String? businessId,
    String? role,
  }) : super(
          id: id,
          email: email,
          accessToken: accessToken,
          refreshToken: refreshToken,
          isEmailVerified: isEmailVerified,
          businessId: businessId,
          role: role,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      final accessToken = json['accessToken'] as String;
      final refreshToken = json['refreshToken'] as String?;

      // Decode JWT payload
      final payload = _decodeJwt(accessToken);

      // Get values from JWT
      final userId = _getPayloadValue<String>(payload, 'userId');
      
      // Since email is not in the JWT, we'll set it to an empty string for now
      // You might want to update this once the backend includes email in the JWT
      const email = '';

      return UserModel(
        id: userId,
        email: email,
        accessToken: accessToken,
        refreshToken: refreshToken,
        isEmailVerified: payload['isEmailVerified'] ?? false,
        businessId: payload['businessDetails']?['id'],
        role: payload['role'],
      );
    } on FormatException catch (e) {
      throw FormatException('UserModel parsing failed: ${e.message}');
    }
  }

  static T _getPayloadValue<T>(Map<String, dynamic> payload, String key) {
    final value = payload[key];
    if (value is T) return value;
    throw FormatException('Missing/invalid field "$key" in JWT');
  }

  static Map<String, dynamic> _decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw FormatException('Invalid JWT');
    try {
      return json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))
      );
    } catch (e) {
      throw FormatException('JWT decode error: $e');
    }
  }

  Map<String, dynamic> toJson() {
    // Implement this method if needed
    return {
      'id': id,
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'isEmailVerified': isEmailVerified,
      'businessId': businessId,
      'role': role,
    };
  }
}

