import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/business_entity.dart';
import '../repositories/business_repository.dart';

class GetBusinessesParams {
  final int page;
  final int limit;

  GetBusinessesParams({
    this.page = 1,
    this.limit = 10,
  });
}

class GetBusinesses implements UseCase<List<BusinessEntity>, GetBusinessesParams> {
  final BusinessRepository repository;

  GetBusinesses(this.repository);

  @override
  Future<Either<Failure, List<BusinessEntity>>> call(
    GetBusinessesParams params,
  ) async {
    return await repository.getBusinesses(
      page: params.page,
      limit: params.limit,
    );
  }
}

