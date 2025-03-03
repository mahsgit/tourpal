import 'package:flutter/material.dart';
import '../../domain/entities/itinerary.dart';

class ItineraryView extends StatelessWidget {
  final Itinerary itinerary;
  final Function(String, Activity, Activity) onActivityEdit;

  const ItineraryView({
    Key? key,
    required this.itinerary,
    required this.onActivityEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (var dayPlan in itinerary.daysPlan) ...[
          Text(
            dayPlan.day,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          for (var activity in dayPlan.activities) ...[
            Card(
              child: ListTile(
                title: Text(activity.place),
                subtitle: Text(activity.description),
                trailing: Text(activity.time),
                onTap: () => _showEditDialog(context, dayPlan.day, activity),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 16),
        ],
        const Divider(),
        _buildSection('Top Places to Visit', itinerary.topPlacesToVisit),
        _buildSection('Top Restaurants to Try', itinerary.topRestaurantsToTry),
        _buildSection('Top Activities to Do', itinerary.topActivitiesToDo),
        _buildSection('Packing Checklist', itinerary.packingChecklist),
      ],
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...items.map((item) => Text('• $item')),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showEditDialog(BuildContext context, String dayPlanDay, Activity activity) {
    showDialog(
      context: context,
      builder: (context) {
        String newPlace = activity.place;
        String newDescription = activity.description;
        String newTime = activity.time;

        return AlertDialog(
          title: const Text('Edit Activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Place'),
                controller: TextEditingController(text: newPlace),
                onChanged: (value) => newPlace = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                controller: TextEditingController(text: newDescription),
                onChanged: (value) => newDescription = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Time'),
                controller: TextEditingController(text: newTime),
                onChanged: (value) => newTime = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newActivity = Activity(
                  time: newTime,
                  place: newPlace,
                  description: newDescription,
                  longitude: activity.longitude,
                  latitude: activity.latitude,
                );
                onActivityEdit(dayPlanDay, activity, newActivity);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

