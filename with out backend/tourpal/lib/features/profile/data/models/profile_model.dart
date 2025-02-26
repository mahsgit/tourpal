import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required String id,
    required String name,
    required String imageUrl,
    required String address,
    required bool isPremium,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          address: address,
          isPremium: isPremium,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      address: json['address'],
      isPremium: json['isPremium'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'address': address,
      'isPremium': isPremium,
    };
  }
}

