import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/room_type.dart';
import '../repositories/room_repository.dart';
class GetRoomTypesParams {
  final String businessId;
  

  GetRoomTypesParams({
    required this.businessId,
  });
}
class GetRoomTypes implements UseCase<List<RoomType>, String> {
  final RoomRepository repository;

  GetRoomTypes(this.repository);

  @override
  Future<Either<Failure, List<RoomType>>> call(String businessId) async {
    return await repository.getRoomTypes(businessId);
  }
}

