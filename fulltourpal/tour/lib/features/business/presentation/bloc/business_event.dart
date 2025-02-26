import 'package:equatable/equatable.dart';

abstract class BusinessEvent extends Equatable {
  const BusinessEvent();

  @override
  List<Object> get props => [];
}

class LoadBusinesses extends BusinessEvent {}

class LoadBusinessDetails extends BusinessEvent {
  final String businessId;

  const LoadBusinessDetails(this.businessId);

  @override
  List<Object> get props => [businessId];
}

class LoadMoreBusinesses extends BusinessEvent {
  final int page;
  final int limit;

  const LoadMoreBusinesses({
    required this.page,
    required this.limit,
  });

  @override
  List<Object> get props => [page, limit];
}

