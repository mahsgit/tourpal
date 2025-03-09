import 'package:flutter/material.dart';
import '../../domain/entities/availability.dart';

class AvailabilityDisplay extends StatelessWidget {
  final List<Availability> availabilities;

  const AvailabilityDisplay({
    Key? key,
    required this.availabilities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (availabilities.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('No availability information found.'),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Time Ranges',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: availabilities.length,
              itemBuilder: (context, index) {
                final availability = availabilities[index];
                return ListTile(
                  title: Text(
                    'From: ${_formatDate(availability.startDate)}',
                  ),
                  subtitle: Text(
                    'To: ${_formatDate(availability.endDate)}',
                  ),
                  leading: const Icon(Icons.event_available),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    if (date.year == 1970) {
      return 'Any date';
    } else if (date.year == 2100) {
      return 'Any date';
    }
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

