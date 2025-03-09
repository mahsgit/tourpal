import 'package:flutter/material.dart';
import 'package:tour/features/notification/data/notifcation.dart';
import 'package:tour/features/notification/domain/entity.dart';
import 'package:tour/features/notification/page/nitem.dart';
import 'package:tour/features/notification/page/nopage.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.init();
  }

  void _deleteNotification(String id) {
    _notificationService.deleteNotification(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _viewNotificationDetails(NotificationEntity notification) {
    _notificationService.markAsRead(notification.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationDetailPage(notification: notification),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              _notificationService.markAllAsRead();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications marked as read'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: ValueListenableBuilder<List<NotificationEntity>>(
        valueListenable: _notificationService.notificationsNotifier,
        builder: (context, notifications, child) {
          if (notifications.isEmpty) {
            return const Center(
              child: Text('No notifications'),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Dismissible(
                key: Key(notification.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    // Delete notification
                    _deleteNotification(notification.id);
                    return true;
                  } else if (direction == DismissDirection.endToStart) {
                    // View notification details
                    _viewNotificationDetails(notification);
                    return false;
                  }
                  return false;
                },
                child: NotificationItem(
                  notification: notification,
                  onTap: () => _viewNotificationDetails(notification),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Simulate a new hotel reservation notification
          _notificationService.addReservationNotification(
            'Grand Hotel',
            'reservation_${DateTime.now().millisecondsSinceEpoch}',
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('New reservation notification added'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Simulate reservation notification',
      ),
    );
  }
}

