part of 'hotel_bloc.dart';

abstract class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelsLoaded extends HotelState {
  final List<HotelEntity> hotels;

  const HotelsLoaded(this.hotels);

  @override
  List<Object> get props => [hotels];
}

class HotelDetailsLoaded extends HotelState {
  final HotelEntity hotel;

  const HotelDetailsLoaded(this.hotel);

  @override
  List<Object> get props => [hotel];
}

class HotelError extends HotelState {
  final String message;

  const HotelError(this.message);

  @override
  List<Object> get props => [message];
}

