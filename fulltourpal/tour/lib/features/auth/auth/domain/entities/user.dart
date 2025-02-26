// import 'package:equatable/equatable.dart';

// class User extends Equatable {
//   final String id;
//   final String email;
//   final String? accessToken;
//   final String? refreshToken;
//   final bool isEmailVerified;
//   final String? businessId;
//   final String? role;

//   const User({
//     required this.id,
//     required this.email,
//     this.accessToken,
//     this.refreshToken,
//     this.isEmailVerified = false,
//     this.businessId,
//     this.role,
//   });

//   @override
//   List<Object?> get props => [id, email, accessToken, refreshToken, isEmailVerified, businessId, role];
// }


class User {
  final String id;
  final String email;
  final String accessToken;
  final String? refreshToken;
  final bool isEmailVerified;
  final String? businessId;
  final String? role;

  const User({
    required this.id,
    required this.email,
    required this.accessToken,
    this.refreshToken,
    this.isEmailVerified = false,
    this.businessId,
    this.role,
  });

  factory User.fromUser(User user) {
    return User(
      id: user.id,
      email: user.email,
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
      isEmailVerified: user.isEmailVerified,
      businessId: user.businessId,
      role: user.role,
    );
  }
}