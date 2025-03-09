import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tour/features/notification/domain/entity.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationDetailPage({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.imageUrl != null) ...[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    notification.imageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              notification.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTypeChip(),
                const SizedBox(width: 8),
                Text(
                  timeago.format(notification.timestamp),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              notification.message,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip() {
    String label;
    Color color;

    switch (notification.type) {
      case NotificationType.newHotel:
        label = 'New Hotel';
        color = Colors.blue;
        break;
      case NotificationType.reservation:
        label = 'Reservation';
        color = Colors.green;
        break;
      case NotificationType.offer:
        label = 'Offer';
        color = Colors.orange;
        break;
      case NotificationType.system:
        label = 'System';
        color = Colors.purple;
        break;
    }

    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    switch (notification.type) {
      case NotificationType.newHotel:
        return ElevatedButton(
          onPressed: () {
            // Navigate to hotel details
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Navigating to hotel ${notification.actionId}'),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('View Hotel'),
        );
      case NotificationType.reservation:
        return ElevatedButton(
          onPressed: () {
            // Navigate to reservation details
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Navigating to reservation ${notification.actionId}'),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('View Reservation'),
        );
      case NotificationType.offer:
        return ElevatedButton(
          onPressed: () {
            // Navigate to offer details
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Navigating to offer ${notification.actionId}'),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('View Offer'),
        );
      case NotificationType.system:
        return const SizedBox.shrink(); // No action for system notifications
    }
  }
}

