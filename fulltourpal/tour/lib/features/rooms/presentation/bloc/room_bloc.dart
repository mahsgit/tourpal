import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/room_type.dart';
import '../../domain/usecases/get_room_types.dart';
import '../../domain/usecases/get_room_type_details.dart';
import '../../domain/usecases/search_room_types.dart';

// Events
abstract class RoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetRoomTypesEvent extends RoomEvent {
  final String businessId;

  GetRoomTypesEvent(this.businessId);

  @override
  List<Object?> get props => [businessId];
}

class GetRoomTypeDetailsEvent extends RoomEvent {
  final String roomTypeId;

  GetRoomTypeDetailsEvent(this.roomTypeId);

  @override
  List<Object?> get props => [roomTypeId];
}

class SearchRoomTypesEvent extends RoomEvent {
  final String query;

  SearchRoomTypesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

// States
abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomTypesLoaded extends RoomState {
  final List<RoomType> roomTypes;

  RoomTypesLoaded(this.roomTypes);

  @override
  List<Object?> get props => [roomTypes];
}

class RoomTypeDetailsLoaded extends RoomState {
  final RoomType roomType;

  RoomTypeDetailsLoaded(this.roomType);

  @override
  List<Object?> get props => [roomType];
}

class RoomError extends RoomState {
  final String message;

  RoomError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final GetRoomTypes getRoomTypes;
  final GetRoomTypeDetails getRoomTypeDetails;
  final SearchRoomTypes searchRoomTypes;

  RoomBloc({
    required this.getRoomTypes,
    required this.getRoomTypeDetails,
    required this.searchRoomTypes,
  }) : super(RoomInitial()) {
    on<GetRoomTypesEvent>(_onGetRoomTypes);
    on<GetRoomTypeDetailsEvent>(_onGetRoomTypeDetails);
    on<SearchRoomTypesEvent>(_onSearchRoomTypes);
  }

  Future<void> _onGetRoomTypes(
    GetRoomTypesEvent event,
    Emitter<RoomState> emit,
  ) async {
    emit(RoomLoading());
    final result = await getRoomTypes(event.businessId);
    result.fold(
      (failure) => emit(RoomError(failure.message)),
      (roomTypes) => emit(RoomTypesLoaded(roomTypes)),
    );
  }

  Future<void> _onGetRoomTypeDetails(
    GetRoomTypeDetailsEvent event,
    Emitter<RoomState> emit,
  ) async {
    emit(RoomLoading());
    final result = await getRoomTypeDetails(event.roomTypeId);
    result.fold(
      (failure) => emit(RoomError(failure.message)),
      (roomType) => emit(RoomTypeDetailsLoaded(roomType)),
    );
  }

  Future<void> _onSearchRoomTypes(
    SearchRoomTypesEvent event,
    Emitter<RoomState> emit,
  ) async {
    emit(RoomLoading());
    final result = await searchRoomTypes(event.query);
    result.fold(
      (failure) => emit(RoomError(failure.message)),
      (roomTypes) => emit(RoomTypesLoaded(roomTypes)),
    );
  }
}

