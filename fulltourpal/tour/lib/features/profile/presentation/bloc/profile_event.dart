import 'package:equatable/equatable.dart';
import '../../domain/entities/user_profile_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfileRequested extends ProfileEvent {
  final UserProfileEntity profile;

  const UpdateProfileRequested({required this.profile});

  @override
  List<Object> get props => [profile];
}

class DeleteProfileRequested extends ProfileEvent {}

