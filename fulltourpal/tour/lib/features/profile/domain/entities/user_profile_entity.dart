import 'package:equatable/equatable.dart';
import 'package:tour/features/profile/data/models/user_profile_model.dart';
import 'address_entity.dart';
import 'profile_picture_entity.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? nationality;
  final ProfilePictureEntity? profilePicture;
  final AddressEntity? address;
  final DateTime registrationDate;
  final bool isComplete;
  final bool emailVerified;

  const UserProfileEntity({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.nationality,
    this.profilePicture,
    this.address,
    required this.registrationDate,
    required this.isComplete,
    required this.emailVerified,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        phoneNumber,
        nationality,
        profilePicture,
        address,
        registrationDate,
        isComplete,
        emailVerified,
      ];

  String get fullName => '$firstName $lastName';
   UserProfileModel toModel() {
    return UserProfileModel(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      nationality:nationality,
      profilePicture: profilePicture?.toModel(),
      address: address?.toModel(),
      registrationDate: registrationDate,
      isComplete: isComplete,
      emailVerified: emailVerified,
    );


}
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber:phoneNumber,
      nationality: nationality,
      profilePicture: profilePicture,
      address: address,
      registrationDate: registrationDate,
      isComplete: isComplete,
      emailVerified: emailVerified,
    );
}

}