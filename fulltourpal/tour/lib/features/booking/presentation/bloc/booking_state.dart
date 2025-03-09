import 'package:equatable/equatable.dart';
import '../../domain/entities/availability.dart';
import '../../domain/entities/booking.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class AvailableTimeRangesLoaded extends BookingState {
  final List<Availability> availabilities;

  const AvailableTimeRangesLoaded(this.availabilities);

  @override
  List<Object?> get props => [availabilities];
}

class AvailableRoomTypesLoaded extends BookingState {
  final List<String> roomTypeIds;

  const AvailableRoomTypesLoaded(this.roomTypeIds);

  @override
  List<Object?> get props => [roomTypeIds];
}

class BookingReserved extends BookingState {
  final Booking booking;

  const BookingReserved(this.booking);

  @override
  List<Object?> get props => [booking];
}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}

