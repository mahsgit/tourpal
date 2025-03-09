import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  const BookingModel({
    required String id,
    required String userId,
    required String roomId,
    required DateTime startDate,
    required DateTime endDate,
  }) : super(
          id: id,
          userId: userId,
          roomId: roomId,
          startDate: startDate,
          endDate: endDate,
        );

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'] ?? '',
      userId: json['UserId'],
      roomId: json['RoomId'],
      startDate: DateTime.parse(json['StartDate']),
      endDate: DateTime.parse(json['EndDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'RoomId': roomId,
      'StartDate': startDate.toIso8601String(),
      'EndDate': endDate.toIso8601String(),
    };
  }
}

