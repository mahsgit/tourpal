import 'package:tourpal/features/trip_advisor/domain/entity/trip_preference.dart';

class Itinerary {
  final String id;
  final List<DayPlan> days;
  final TripPreferences preferences;

  Itinerary({
    required this.id,
    required this.days,
    required this.preferences,
  });
}

class DayPlan {
  final String id;
  final int dayNumber;
  final List<Activity> activities;

  DayPlan({
    required this.id,
    required this.dayNumber,
    required this.activities,
  });
}

class Activity {
  final String id;
  final String name;
  final String description;
  final String location;
  final String mapLink;
  final String bookingLink;
  final double price;
  final DateTime startTime;
  final DateTime endTime;

  Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.mapLink,
    required this.bookingLink,
    required this.price,
    required this.startTime,
    required this.endTime,
  });
}

