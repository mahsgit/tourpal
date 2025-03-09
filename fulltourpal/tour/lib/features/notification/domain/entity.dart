import 'package:equatable/equatable.dart';

enum NotificationType {
  newHotel,
  reservation,
  offer,
  system
}

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final NotificationType type;
  final String? imageUrl;
  final String? actionId; // ID of the related item (hotel, reservation, etc.)

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    required this.type,
    this.imageUrl,
    this.actionId,
  });

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    bool? isRead,
    NotificationType? type,
    String? imageUrl,
    String? actionId,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      actionId: actionId ?? this.actionId,
    );
  }

  @override
  List<Object?> get props => [id, title, message, timestamp, isRead, type, imageUrl, actionId];
}

