import '../../domain/entities/profile_picture_entity.dart';

class ProfilePictureModel extends ProfilePictureEntity {
  const ProfilePictureModel({
    required String mediaType,
    required String url,
  }) : super(
          mediaType: mediaType,
          url: url,
        );

  factory ProfilePictureModel.fromJson(Map<String, dynamic> json) {
    return ProfilePictureModel(
      mediaType: json['mediaType'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mediaType': mediaType,
      'url': url,
    };
  }
}

