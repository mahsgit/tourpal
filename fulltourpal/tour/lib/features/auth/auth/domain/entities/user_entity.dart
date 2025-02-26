// // import 'package:equatable/equatable.dart';

// // class UserEntity extends Equatable {
// //   final String id;
// //   final String email;
// //   final String? accessToken;
// //   final String? refreshToken;

// //   const UserEntity({
// //     required this.id,
// //     required this.email,
// //     this.accessToken,
// //     this.refreshToken,
// //   });
  

// //   @override
// //   List<Object?> get props => [id, email, accessToken, refreshToken];
// // }

// import 'package:equatable/equatable.dart';
// import 'package:tour/features/auth/domain/entities/user.dart';

// class UserEntity extends Equatable {
//   final String id;
//   final String email;
//   final String? accessToken;
//   final String? refreshToken;

//   const UserEntity({
//     required this.id,
//     required this.email,
//     this.accessToken,
//     this.refreshToken,
//   });

//   // Define the fromUser method
//   factory UserEntity.fromUser(User user) {
//     return UserEntity(
//       id: user.id,
//       email: user.email,
//       accessToken: user.accessToken,
//       refreshToken: user.refreshToken,
//     );
//   }

//   @override
//   List<Object?> get props => [id, email, accessToken, refreshToken];
// }

// // Define the User class
// // class User {
// //   final String id;
// //   final String email;
// //   final String? accessToken;
// //   final String? refreshToken;

// //   User({
// //     required this.id,
// //     required this.email,
// //     this.accessToken,
// //     this.refreshToken,
// //   });
// // }


// class User {
//   final String id;
//   final String email;
//   final String accessToken;
//   final String? refreshToken;
//   final bool isEmailVerified;
//   final String? businessId;
//   final String? role;

//   const User({
//     required this.id,
//     required this.email,
//     required this.accessToken,
//     this.refreshToken,
//     this.isEmailVerified = false,
//     this.businessId,
//     this.role,
//   });
// }

