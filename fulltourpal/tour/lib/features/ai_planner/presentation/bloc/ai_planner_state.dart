import 'package:equatable/equatable.dart';
import '../../domain/entities/itinerary.dart';

abstract class AIPlannerState extends Equatable {
  const AIPlannerState();

  @override
  List<Object> get props => [];
}

class AIPlannerInitial extends AIPlannerState {}

class AIPlannerLoading extends AIPlannerState {}

class AIPlannerLoaded extends AIPlannerState {
  final Itinerary itinerary;

  const AIPlannerLoaded({required this.itinerary});

  @override
  List<Object> get props => [itinerary];
}

class AIPlannerError extends AIPlannerState {
  final String message;

  const AIPlannerError({required this.message});

  @override
  List<Object> get props => [message];
}

