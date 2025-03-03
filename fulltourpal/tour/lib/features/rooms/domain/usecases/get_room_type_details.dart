import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/room_type.dart';
import '../repositories/room_repository.dart';

class GetRoomTypeDetails implements UseCase<RoomType, String> {
  final RoomRepository repository;

  GetRoomTypeDetails(this.repository);

  @override
  Future<Either<Failure, RoomType>> call(String roomTypeId) async {
    return await repository.getRoomTypeDetails(roomTypeId);
  }
}

