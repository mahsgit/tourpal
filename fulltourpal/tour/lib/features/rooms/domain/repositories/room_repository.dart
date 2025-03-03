import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/room_type.dart';

abstract class RoomRepository {
  Future<Either<Failure, List<RoomType>>> getRoomTypes(String businessId);
  Future<Either<Failure, RoomType>> getRoomTypeDetails(String roomTypeId);
  Future<Either<Failure, List<RoomType>>> searchRoomTypes(String query);
}

