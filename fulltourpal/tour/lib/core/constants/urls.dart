// class Urls {
//   static const String baseUrl = 'https://tourpal-1.onrender.com/api/auth';
  
//   static const String register = '$baseUrl/register';
//   static const String login = '$baseUrl/login';
//   static const String googleLogin = '$baseUrl/google';
//   static const String logout = '$baseUrl/logout';
//   static const String logoutAll = '$baseUrl/logout/all';
//   static const String refreshToken = '$baseUrl/refresh-token';
//   static const String forgotPassword = '$baseUrl/forgot-password';
//   static const String resetPassword = '$baseUrl/reset-password';
//   static const String validateEmail = '$baseUrl/validate-email';
//   static const String getCurrentProfile = '$baseUrl/api/users/me';
// }

class Urls {
  static const String baseUrl = 'https://tourpal-1.onrender.com/api';
  static const String authUrl = '$baseUrl/auth';
  
  // Auth endpoints
  static const String register = '$authUrl/register';
  static const String login = '$authUrl/login';
  static const String googleLogin = '$authUrl/google';
  static const String logout = '$authUrl/logout';
  static const String logoutAll = '$authUrl/logout/all';
  static const String refreshToken = '$authUrl/refresh-token';
  static const String forgotPassword = '$authUrl/forgot-password';
  static const String resetPassword = '$authUrl/reset-password';
  static const String validateEmail = '$authUrl/validate-email';

  // Profile endpoints
  static const String getCurrentProfile = '$baseUrl/users/me';
  static const String updateProfile = '$baseUrl/users/me';
  static const String deleteProfile = '$baseUrl/users/me';
}

