
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
  static const String updateProfile = '$baseUrl/users';
  static const String deleteProfile = '$baseUrl/users';

  //business
  static const String businesses = '$baseUrl/businesses';

  //room
   static const String getRoomTypes = '$baseUrl/room-types/business';
  static const String getRoomTypeDetails = '$baseUrl/room-types';
  static const String searchRoomTypes = '$baseUrl/room-types/search';

  //ai
  static const String aiPlanner = '$baseUrl/aiplan/generate';
}

