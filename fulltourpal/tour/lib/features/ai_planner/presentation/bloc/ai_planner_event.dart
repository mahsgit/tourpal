import 'package:equatable/equatable.dart';
import '../../domain/entities/itinerary.dart';
import '../../domain/entities/trip_preferences.dart';

abstract class AIPlannerEvent extends Equatable {
  const AIPlannerEvent();

  @override
  List<Object> get props => [];
}

class GenerateItineraryEvent extends AIPlannerEvent {
  final TripPreferences preferences;

  const GenerateItineraryEvent(this.preferences);

  @override
  List<Object> get props => [preferences];
}

class UpdateActivityEvent extends AIPlannerEvent {
  final String dayPlanDay;
  final Activity oldActivity;
  final Activity newActivity;

  const UpdateActivityEvent({
    required this.dayPlanDay,
    required this.oldActivity,
    required this.newActivity,
  });

  @override
  List<Object> get props => [dayPlanDay, oldActivity, newActivity];
}

