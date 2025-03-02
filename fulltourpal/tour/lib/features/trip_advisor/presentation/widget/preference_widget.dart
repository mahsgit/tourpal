import 'package:flutter/material.dart';
import 'package:tour/features/trip_advisor/domain/entity/trip_preference.dart';

class PreferenceForm extends StatefulWidget {
  final Function(TripPreferences) onSubmit;

  const PreferenceForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<PreferenceForm> createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  final _formKey = GlobalKey<FormState>();
  String _location = '';
  DateTime _date = DateTime.now();
  String _time = '';
  String _travelerType = 'Students';
  double _budget = 100;
  List<String> _selectedPlaceTypes = [];
  List<String> _selectedActivities = [];
  int _numberOfPeople = 1;

  final List<String> _placeTypes = [
    'Historic',
    'Modern',
    'Royal',
    'Heritage',
    'Palace',
  ];

  final List<String> _activities = [
    'Sightseeing',
    'Food',
    'Adventure',
    'Shopping',
    'Cultural experience',
    'Nature and Wildlife',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Search location',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => _location = value,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildDateTimePicker(),
            const SizedBox(height: 16),
            _buildTravelerType(),
            const SizedBox(height: 16),
            _buildBudgetSlider(),
            const SizedBox(height: 16),
            _buildPlaceTypes(),
            const SizedBox(height: 16),
            _buildActivities(),
            const SizedBox(height: 16),
            _buildPeopleCounter(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Generate',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Date', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _date,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              setState(() => _date = date);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(
                  '${_date.day}/${_date.month}/${_date.year}',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTravelerType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Travelers Type', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            'Students',
            'Families',
            'Business Travelers',
          ].map((type) {
            return ChoiceChip(
              label: Text(type),
              selected: _travelerType == type,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _travelerType = type);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBudgetSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Budget', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Slider(
          value: _budget,
          min: 50,
          max: 200,
          divisions: 15,
          label: '\$${_budget.round()}',
          onChanged: (value) {
            setState(() => _budget = value);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$50'),
            Text('\$200'),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceTypes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Type of place', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _placeTypes.map((type) {
            return FilterChip(
              label: Text(type),
              selected: _selectedPlaceTypes.contains(type),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedPlaceTypes.add(type);
                  } else {
                    _selectedPlaceTypes.remove(type);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Activities and Interests', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _activities.map((activity) {
            return FilterChip(
              label: Text(activity),
              selected: _selectedActivities.contains(activity),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedActivities.add(activity);
                  } else {
                    _selectedActivities.remove(activity);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPeopleCounter() {
    return Row(
      children: [
        const Text('Number of People', style: TextStyle(fontSize: 16)),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (_numberOfPeople > 1) {
              setState(() => _numberOfPeople--);
            }
          },
        ),
        Text('$_numberOfPeople'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() => _numberOfPeople++);
          },
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final preferences = TripPreferences(
        location: _location,
        date: _date,
        time: _time,
        travelerType: _travelerType,
        budget: _budget,
        placeTypes: _selectedPlaceTypes,
        activities: _selectedActivities,
        numberOfPeople: _numberOfPeople,
      );
      widget.onSubmit(preferences);
    }
  }
}

