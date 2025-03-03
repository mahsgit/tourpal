import 'package:flutter/material.dart';
import '../../domain/entities/trip_preferences.dart';

class PreferenceForm extends StatefulWidget {
  final Function(TripPreferences) onSubmit;

  const PreferenceForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _PreferenceFormState createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  final _formKey = GlobalKey<FormState>();
  String _destination = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));
  String _travelType = 'family';
  List<String> _preferences = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Destination'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a destination';
              }
              return null;
            },
            onSaved: (value) => _destination = value!,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Start Date'),
                  readOnly: true,
                  controller: TextEditingController(
                    text: _startDate.toIso8601String().split('T')[0],
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _startDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() => _startDate = date);
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'End Date'),
                  readOnly: true,
                  controller: TextEditingController(
                    text: _endDate.toIso8601String().split('T')[0],
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _endDate,
                      firstDate: _startDate,
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() => _endDate = date);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Travel Type'),
            value: _travelType,
            items: ['family', 'solo', 'couple', 'friends'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => _travelType = value!);
            },
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              'museums',
              'historical sites',
              'local food',
              'parks',
              'shopping',
              'nightlife'
            ].map((String preference) {
              return FilterChip(
                label: Text(preference),
                selected: _preferences.contains(preference),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _preferences.add(preference);
                    } else {
                      _preferences.remove(preference);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.onSubmit(TripPreferences(
                  destination: _destination,
                  startDate: _startDate,
                  endDate: _endDate,
                  travelType: _travelType,
                  preferences: _preferences,
                ));
              }
            },
            child: const Text('Generate Itinerary'),
          ),
        ],
      ),
    );
  }
}

