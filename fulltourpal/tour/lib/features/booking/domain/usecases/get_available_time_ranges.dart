import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/availability.dart';
import '../repositories/booking_repository.dart';

class GetAvailableTimeRanges implements UseCase<List<Availability>, AvailabilityParams> {
  final BookingRepository repository;

  GetAvailableTimeRanges(this.repository);

  @override
  Future<Either<Failure, List<Availability>>> call(AvailabilityParams params) async {
    return await repository.getAvailableTimeRanges(
      businessId: params.businessId,
      roomTypeId: params.roomTypeId,
    );
  }
}

class AvailabilityParams extends Equatable {
  final String businessId;
  final String roomTypeId;

  const AvailabilityParams({
    required this.businessId,
    required this.roomTypeId,
  });

  @override
  List<Object?> get props => [businessId, roomTypeId];
}

