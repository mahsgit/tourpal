import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String id;
  final String userId;
  final String roomId;
  final DateTime startDate;
  final DateTime endDate;

  const Booking({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [id, userId, roomId, startDate, endDate];
}

