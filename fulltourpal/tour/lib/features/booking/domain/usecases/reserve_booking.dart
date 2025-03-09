import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class ReserveBooking implements UseCase<Booking, Booking> {
  final BookingRepository repository;

  ReserveBooking(this.repository);

  @override
  Future<Either<Failure, Booking>> call(Booking booking) async {
    return await repository.reserveBooking(booking);
  }
}

