import 'package:flutter/material.dart';
import 'package:tour/features/trip_advisor/domain/entity/trip_entity.dart';

class EditActivityDialog extends StatefulWidget {
  final Activity activity;

  const EditActivityDialog({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  State<EditActivityDialog> createState() => _EditActivityDialogState();
}

class _EditActivityDialogState extends State<EditActivityDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _priceController;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.activity.name);
    _descriptionController = TextEditingController(text: widget.activity.description);
    _locationController = TextEditingController(text: widget.activity.location);
    _priceController = TextEditingController(text: widget.activity.price.toString());
    _startTime = TimeOfDay.fromDateTime(widget.activity.startTime);
    _endTime = TimeOfDay.fromDateTime(widget.activity.endTime);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Activity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Activity Name',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                prefixText: '\$',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _startTime,
                    );
                    if (time != null) {
                      setState(() => _startTime = time);
                    }
                  },
                  child: Text('Start Time: ${_startTime.format(context)}'),
                ),
                TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _endTime,
                    );
                    if (time != null) {
                      setState(() => _endTime = time);
                    }
                  },
                  child: Text('End Time: ${_endTime.format(context)}'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final updatedActivity = Activity(
                      id: widget.activity.id,
                      name: _nameController.text,
                      description: _descriptionController.text,
                      location: _locationController.text,
                      mapLink: widget.activity.mapLink,
                      bookingLink: widget.activity.bookingLink,
                      price: double.tryParse(_priceController.text) ?? widget.activity.price,
                      startTime: DateTime(
                        widget.activity.startTime.year,
                        widget.activity.startTime.month,
                        widget.activity.startTime.day,
                        _startTime.hour,
                        _startTime.minute,
                      ),
                      endTime: DateTime(
                        widget.activity.endTime.year,
                        widget.activity.endTime.month,
                        widget.activity.endTime.day,
                        _endTime.hour,
                        _endTime.minute,
                      ),
                    );
                    Navigator.pop(context, updatedActivity);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}