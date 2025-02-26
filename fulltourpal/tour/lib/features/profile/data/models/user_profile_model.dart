import '../../domain/entities/user_profile_entity.dart';
import 'address_model.dart';
import 'profile_picture_model.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? nationality,
    ProfilePictureModel? profilePicture,
    AddressModel? address,
    required DateTime registrationDate,
    required bool isComplete,
    required bool emailVerified,
  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          nationality: nationality,
          profilePicture: profilePicture,
          address: address,
          registrationDate: registrationDate,
          isComplete: isComplete,
          emailVerified: emailVerified,
        );

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      nationality: json['nationality'],
      profilePicture: json['profilePicture'] != null
          ? ProfilePictureModel.fromJson(json['profilePicture'])
          : null,
      address:
          json['address'] != null ? AddressModel.fromJson(json['address']) : null,
      registrationDate: DateTime.parse(json['registrationDate']),
      isComplete: json['isComplete'],
      emailVerified: json['emailVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'nationality': nationality,
      'profilePicture': profilePicture != null
          ? (profilePicture as ProfilePictureModel).toJson()
          : null,
      'address': address != null ? (address as AddressModel).toJson() : null,
    };
  }
}

