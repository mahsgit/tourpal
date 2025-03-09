import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_available_room_types.dart';
import '../../domain/usecases/get_available_time_ranges.dart';
import '../../domain/usecases/reserve_booking.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetAvailableTimeRanges getAvailableTimeRanges;
  final GetAvailableRoomTypes getAvailableRoomTypes;
  final ReserveBooking reserveBooking;

  BookingBloc({
    required this.getAvailableTimeRanges,
    required this.getAvailableRoomTypes,
    required this.reserveBooking,
  }) : super(BookingInitial()) {
    on<GetAvailableTimeRangesEvent>(_onGetAvailableTimeRanges);
    on<GetAvailableRoomTypesEvent>(_onGetAvailableRoomTypes);
    on<ReserveBookingEvent>(_onReserveBooking);
  }

  Future<void> _onGetAvailableTimeRanges(
    GetAvailableTimeRangesEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    final result = await getAvailableTimeRanges(
      AvailabilityParams(
        businessId: event.businessId,
        roomTypeId: event.roomTypeId,
      ),
    );
    result.fold(
      (failure) => emit(BookingError(failure.message)),
      (availabilities) => emit(AvailableTimeRangesLoaded(availabilities)),
    );
  }

  Future<void> _onGetAvailableRoomTypes(
    GetAvailableRoomTypesEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    final result = await getAvailableRoomTypes(
      AvailableRoomTypesParams(
        businessId: event.businessId,
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );
    result.fold(
      (failure) => emit(BookingError(failure.message)),
      (roomTypeIds) => emit(AvailableRoomTypesLoaded(roomTypeIds)),
    );
  }

  Future<void> _onReserveBooking(
    ReserveBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    final result = await reserveBooking(event.booking);
    result.fold(
      (failure) => emit(BookingError(failure.message)),
      (booking) => emit(BookingReserved(booking)),
    );
  }
}

