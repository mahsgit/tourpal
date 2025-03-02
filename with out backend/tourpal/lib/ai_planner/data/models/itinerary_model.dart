import '../../domain/entities/itinerary.dart';

class ItineraryModel extends Itinerary {
  const ItineraryModel({
    required List<DayPlan> daysPlan,
    required List<String> topPlacesToVisit,
    required List<String> topRestaurantsToTry,
    required List<String> topActivitiesToDo,
    required List<String> packingChecklist,
  }) : super(
          daysPlan: daysPlan,
          topPlacesToVisit: topPlacesToVisit,
          topRestaurantsToTry: topRestaurantsToTry,
          topActivitiesToDo: topActivitiesToDo,
          packingChecklist: packingChecklist,
        );

  factory ItineraryModel.fromJson(Map<String, dynamic> json) {
    return ItineraryModel(
      daysPlan: (json['DaysPlan'] as List)
          .map((day) => DayPlan.fromJson(day))
          .toList(),
      topPlacesToVisit: List<String>.from(json['TopPlacesToVisit']),
      topRestaurantsToTry: List<String>.from(json['TopRestaurantsToTry']),
      topActivitiesToDo: List<String>.from(json['TopActivitiesToDo']),
      packingChecklist: List<String>.from(json['PackingChecklist']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DaysPlan': daysPlan.map((day) => day.toJson()).toList(),
      'TopPlacesToVisit': topPlacesToVisit,
      'TopRestaurantsToTry': topRestaurantsToTry,
      'TopActivitiesToDo': topActivitiesToDo,
      'PackingChecklist': packingChecklist,
    };
  }
}

