// part of 'trip_planner_bloc.dart';

import 'package:tourpal/features/trip_advisor/domain/entity/trip_entity.dart';

abstract class TripPlannerState {}

class TripPlannerInitial extends TripPlannerState {}

class TripPlannerLoading extends TripPlannerState {}

class TripPlannerSuccess extends TripPlannerState {
  final Itinerary itinerary;

  TripPlannerSuccess(this.itinerary);
}

class TripPlannerError extends TripPlannerState {
  final String message;

  TripPlannerError(this.message);
}

