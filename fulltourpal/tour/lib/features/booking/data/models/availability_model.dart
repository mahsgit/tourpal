import '../../domain/entities/availability.dart';

class AvailabilityModel extends Availability {
  const AvailabilityModel({
    required DateTime startDate,
    required DateTime endDate,
  }) : super(
          startDate: startDate,
          endDate: endDate,
        );

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}

