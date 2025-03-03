import 'package:equatable/equatable.dart';
import 'package:tour/features/profile/data/models/profile_picture_model.dart';

class ProfilePictureEntity extends Equatable {
  final String mediaType;
  final String url;

  const ProfilePictureEntity({
    required this.mediaType,
    required this.url,
  });

  @override
  List<Object> get props => [mediaType, url];
  
 
  ProfilePictureModel toModel() {
    return ProfilePictureModel(
      mediaType: mediaType,
      url: url,
      

    );
  }
}


