import 'package:equatable/equatable.dart';

class TripPreferences extends Equatable {
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String travelType;
  final List<String> preferences;

  const TripPreferences({
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.travelType,
    required this.preferences,
  });

  @override
  List<Object?> get props => [destination, startDate, endDate, travelType, preferences];
}

