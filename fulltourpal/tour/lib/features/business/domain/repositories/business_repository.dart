import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/business_entity.dart';

abstract class BusinessRepository {
  Future<Either<Failure, List<BusinessEntity>>> getBusinesses({
    int page = 1,
    int limit = 10,
    String? query,
    double? minPrice,
    double? maxPrice,
    double? minRating,
  });
  Future<Either<Failure, BusinessEntity>> getBusinessDetails(String businessId);
}

