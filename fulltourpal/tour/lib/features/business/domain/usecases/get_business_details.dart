import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/business_entity.dart';
import '../repositories/business_repository.dart';

class GetBusinessDetails implements UseCase<BusinessEntity, String> {
  final BusinessRepository repository;

  GetBusinessDetails(this.repository);

  @override
  Future<Either<Failure, BusinessEntity>> call(String businessId) async {
    return await repository.getBusinessDetails(businessId);
  }
}

