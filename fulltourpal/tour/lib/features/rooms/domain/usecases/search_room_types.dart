import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/room_type.dart';
import '../repositories/room_repository.dart';

class SearchRoomTypes implements UseCase<List<RoomType>, String> {
  final RoomRepository repository;

  SearchRoomTypes(this.repository);

  @override
  Future<Either<Failure, List<RoomType>>> call(String query) async {
    return await repository.searchRoomTypes(query);
  }
}

