import '../../domain/entities/trip_preferences.dart';

class TripPreferencesModel extends TripPreferences {
  const TripPreferencesModel({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required String travelType,
    required List<String> preferences,
  }) : super(
          destination: destination,
          startDate: startDate,
          endDate: endDate,
          travelType: travelType,
          preferences: preferences,
        );

  factory TripPreferencesModel.fromJson(Map<String, dynamic> json) {
    return TripPreferencesModel(
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      travelType: json['travelType'],
      preferences: List<String>.from(json['preferences']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'travelType': travelType,
      'preferences': preferences,
    };
  }
}

