import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/delete_profile.dart';
import '../../domain/usecases/get_current_profile.dart';
import '../../domain/usecases/update_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCurrentProfile getCurrentProfile;
  final UpdateProfile updateProfile;
  final DeleteProfile deleteProfile;

  ProfileBloc({
    required this.getCurrentProfile,
    required this.updateProfile,
    required this.deleteProfile,
  }) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      final result = await getCurrentProfile(NoParams());
      result.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (profile) => emit(ProfileLoaded(profile: profile)),
      );
    });

    on<UpdateProfileRequested>((event, emit) async {
      emit(ProfileLoading());
      final result = await updateProfile(event.profile);
      result.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (profile) => emit(ProfileLoaded(profile: profile)),
      );
    });

    on<DeleteProfileRequested>((event, emit) async {
      emit(ProfileLoading());
      final result = await deleteProfile(NoParams());
      result.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (_) => emit(ProfileDeleted()),
      );
    });
  }
}

