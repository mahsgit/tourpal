import 'package:equatable/equatable.dart';
import '../../domain/entities/business_entity.dart';

abstract class BusinessState extends Equatable {
  const BusinessState();

  @override
  List<Object> get props => [];
}

class BusinessInitial extends BusinessState {}

class BusinessLoading extends BusinessState {}

class BusinessesLoaded extends BusinessState {
  final List<BusinessEntity> businesses;

  const BusinessesLoaded({required this.businesses});

  @override
  List<Object> get props => [businesses];
}

class BusinessDetailsLoaded extends BusinessState {
  final BusinessEntity business;

  const BusinessDetailsLoaded({required this.business});

  @override
  List<Object> get props => [business];
}

class BusinessError extends BusinessState {
  final String message;

  const BusinessError({required this.message});

  @override
  List<Object> get props => [message];
}

