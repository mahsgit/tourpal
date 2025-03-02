// part of 'trip_planner_bloc.dart';

import 'package:tour/features/trip_advisor/domain/entity/trip_entity.dart';
import 'package:tour/features/trip_advisor/domain/entity/trip_preference.dart';

abstract class TripPlannerEvent {}

class GenerateItineraryEvent extends TripPlannerEvent {
  final TripPreferences preferences;

  GenerateItineraryEvent(this.preferences);
}

class UpdateActivityEvent extends TripPlannerEvent {
  final Activity activity;

  UpdateActivityEvent(this.activity);
}

