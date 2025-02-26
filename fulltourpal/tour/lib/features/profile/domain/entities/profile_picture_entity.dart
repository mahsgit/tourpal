import 'package:equatable/equatable.dart';

class ProfilePictureEntity extends Equatable {
  final String mediaType;
  final String url;

  const ProfilePictureEntity({
    required this.mediaType,
    required this.url,
  });

  @override
  List<Object> get props => [mediaType, url];
}

