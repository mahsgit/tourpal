class TripPreferences {
  final String location;
  final DateTime date;
  final String time;
  final String travelerType;
  final double budget;
  final List<String> placeTypes;
  final List<String> activities;
  final int numberOfPeople;

  TripPreferences({
    required this.location,
    required this.date,
    required this.time,
    required this.travelerType,
    required this.budget,
    required this.placeTypes,
    required this.activities,
    required this.numberOfPeople,
  });
}

