import 'package:equatable/equatable.dart';
import '../../domain/entities/booking.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class GetAvailableTimeRangesEvent extends BookingEvent {
  final String businessId;
  final String roomTypeId;

  const GetAvailableTimeRangesEvent({
    required this.businessId,
    required this.roomTypeId,
  });

  @override
  List<Object?> get props => [businessId, roomTypeId];
}

class GetAvailableRoomTypesEvent extends BookingEvent {
  final String businessId;
  final DateTime startDate;
  final DateTime endDate;

  const GetAvailableRoomTypesEvent({
    required this.businessId,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [businessId, startDate, endDate];
}

class ReserveBookingEvent extends BookingEvent {
  final Booking booking;

  const ReserveBookingEvent({required this.booking});

  @override
  List<Object?> get props => [booking];
}

