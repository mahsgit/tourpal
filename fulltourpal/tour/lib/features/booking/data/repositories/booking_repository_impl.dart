import 'package:dartz/dartz.dart';
import 'package:tour/features/booking/data/models/booking_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/availability.dart';
import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Availability>>> getAvailableTimeRanges({
    required String businessId,
    required String roomTypeId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final availabilities = await remoteDataSource.getAvailableTimeRanges(
          businessId: businessId,
          roomTypeId: roomTypeId,
        );
        return Right(availabilities);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAvailableRoomTypes({
    required String businessId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final roomTypes = await remoteDataSource.getAvailableRoomTypes(
          businessId: businessId,
          startDate: startDate,
          endDate: endDate,
        );
        return Right(roomTypes);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Booking>> reserveBooking(Booking booking) async {
    if (await networkInfo.isConnected) {
      try {
        final bookingModel = await remoteDataSource.reserveBooking(
          BookingModel(
            id: booking.id,
            userId: booking.userId,
            roomId: booking.roomId,
            startDate: booking.startDate,
            endDate: booking.endDate,
          ),
        );
        return Right(bookingModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

