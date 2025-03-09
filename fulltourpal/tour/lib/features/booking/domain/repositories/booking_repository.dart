import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/availability.dart';
import '../entities/booking.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<Availability>>> getAvailableTimeRanges({
    required String businessId,
    required String roomTypeId,
  });
  
  Future<Either<Failure, List<String>>> getAvailableRoomTypes({
    required String businessId,
    required DateTime startDate,
    required DateTime endDate,
  });
  
  Future<Either<Failure, Booking>> reserveBooking(Booking booking);
}

