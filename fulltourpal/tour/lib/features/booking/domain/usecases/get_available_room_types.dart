import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/booking_repository.dart';

class GetAvailableRoomTypes implements UseCase<List<String>, AvailableRoomTypesParams> {
  final BookingRepository repository;

  GetAvailableRoomTypes(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(AvailableRoomTypesParams params) async {
    return await repository.getAvailableRoomTypes(
      businessId: params.businessId,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

class AvailableRoomTypesParams extends Equatable {
  final String businessId;
  final DateTime startDate;
  final DateTime endDate;

  const AvailableRoomTypesParams({
    required this.businessId,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [businessId, startDate, endDate];
}

