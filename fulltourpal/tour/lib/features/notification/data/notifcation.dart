import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tour/features/notification/domain/entity.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // In-memory storage for notifications
  final List<NotificationEntity> _notifications = [];
  
  // Stream controller to broadcast notification changes
  final ValueNotifier<List<NotificationEntity>> notificationsNotifier = 
      ValueNotifier<List<NotificationEntity>>([]);
      
  // Notifier for unread count
  final ValueNotifier<int> unreadCountNotifier = ValueNotifier<int>(0);

  // Initialize with dummy data
  void init() {
    if (_notifications.isEmpty) {
      _addDummyNotifications();
    }
    _updateNotifier();
    _updateUnreadCount();
  }

  // Get all notifications
  List<NotificationEntity> getNotifications() {
    return List.from(_notifications);
  }

  // Add a new notification
  void addNotification(NotificationEntity notification) {
    _notifications.add(notification);
    _updateNotifier();
    _updateUnreadCount();
  }

  // Delete a notification
  void deleteNotification(String id) {
    _notifications.removeWhere((notification) => notification.id == id);
    _updateNotifier();
    _updateUnreadCount();
  }

  // Mark a notification as read
  void markAsRead(String id) {
    final index = _notifications.indexWhere((notification) => notification.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      _updateNotifier();
      _updateUnreadCount();
    }
  }

  // Mark all notifications as read
  void markAllAsRead() {
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    _updateNotifier();
    _updateUnreadCount();
  }

  // Get unread count
  int getUnreadCount() {
    return _notifications.where((notification) => !notification.isRead).length;
  }

  // Add a hotel reservation notification
  void addReservationNotification(String hotelName, String reservationId) {
    addNotification(
      NotificationEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Hotel Reserved',
        message: 'You have successfully reserved a room at $hotelName.',
        timestamp: DateTime.now(),
        type: NotificationType.reservation,
        actionId: reservationId,
      ),
    );
  }

  // Add a new hotel notification
  void addNewHotelNotification(String hotelName, String hotelId, String imageUrl) {
    addNotification(
      NotificationEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Hotel Added',
        message: '$hotelName is now available for booking!',
        timestamp: DateTime.now(),
        type: NotificationType.newHotel,
        imageUrl: imageUrl,
        actionId: hotelId,
      ),
    );
  }

  // Update the notifier
  void _updateNotifier() {
    notificationsNotifier.value = List.from(_notifications);
  }
  
  // Update unread count
  void _updateUnreadCount() {
    unreadCountNotifier.value = getUnreadCount();
  }

  // Add dummy notifications for testing
  void _addDummyNotifications() {
    // New hotel notifications
    _notifications.add(
      NotificationEntity(
        id: '1',
        title: 'New Hotel Added',
        message: 'Hilton Addis Ababa is now available for booking!',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: NotificationType.newHotel,
        imageUrl: 'https://example.com/hilton.jpg',
        actionId: 'hotel_123',
      ),
    );

    _notifications.add(
      NotificationEntity(
        id: '2',
        title: 'New Hotel Added',
        message: 'Sheraton Addis is now available for booking!',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.newHotel,
        imageUrl: 'https://example.com/sheraton.jpg',
        actionId: 'hotel_124',
      ),
    );

    // Reservation notifications
    _notifications.add(
      NotificationEntity(
        id: '3',
        title: 'Hotel Reserved',
        message: 'You have successfully reserved a room at Skylight Hotel.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        type: NotificationType.reservation,
        actionId: 'reservation_456',
      ),
    );

    // Offer notifications
    _notifications.add(
      NotificationEntity(
        id: '4',
        title: 'Special Offer',
        message: 'Get 20% off on your next booking at Hyatt Regency!',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        type: NotificationType.offer,
        imageUrl: 'https://example.com/hyatt.jpg',
        actionId: 'offer_789',
      ),
    );

    // System notification
    _notifications.add(
      NotificationEntity(
        id: '5',
        title: 'Profile Updated',
        message: 'Your profile information has been successfully updated.',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        type: NotificationType.system,
      ),
    );
  }
}

