import 'package:equatable/equatable.dart';

class Itinerary extends Equatable {
  final List<DayPlan> daysPlan;
  final List<String> topPlacesToVisit;
  final List<String> topRestaurantsToTry;
  final List<String> topActivitiesToDo;
  final List<String> packingChecklist;

  const Itinerary({
    required this.daysPlan,
    required this.topPlacesToVisit,
    required this.topRestaurantsToTry,
    required this.topActivitiesToDo,
    required this.packingChecklist,
  });

  @override
  List<Object?> get props => [daysPlan, topPlacesToVisit, topRestaurantsToTry, topActivitiesToDo, packingChecklist];
}

class DayPlan extends Equatable {
  final String day;
  final List<Activity> activities;

  const DayPlan({required this.day, required this.activities});

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    final dayEntry = json.entries.first;
    return DayPlan(
      day: dayEntry.key,
      activities: (dayEntry.value as List).map((activity) => Activity.fromJson(activity)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      day: activities.map((activity) => activity.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [day, activities];
}

class Activity extends Equatable {
  final String time;
  final String place;
  final String description;
  final String longitude;
  final String latitude;

  const Activity({
    required this.time,
    required this.place,
    required this.description,
    required this.longitude,
    required this.latitude,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      time: json['Time'],
      place: json['Place'],
      description: json['Description'],
      longitude: json['Longitude'],
      latitude: json['Latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Time': time,
      'Place': place,
      'Description': description,
      'Longitude': longitude,
      'Latitude': latitude,
    };
  }

  @override
  List<Object?> get props => [time, place, description, longitude, latitude];
}

