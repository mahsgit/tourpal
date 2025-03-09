import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final double minPrice;
  final double maxPrice;
  final double minRating;
  final Function(double, double, double) onApplyFilters;

  const FilterDialog({
    Key? key,
    required this.minPrice,
    required this.maxPrice,
    required this.minRating,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late double _minPrice;
  late double _maxPrice;
  late double _minRating;

  @override
  void initState() {
    super.initState();
    _minPrice = widget.minPrice;
    _maxPrice = widget.maxPrice;
    _minRating = widget.minRating;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Options'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPriceFilter(),
            const SizedBox(height: 20),
            _buildRatingFilter(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onApplyFilters(_minPrice, _maxPrice, _minRating);
            Navigator.pop(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }

  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Price Range (\$):'),
        RangeSlider(
          values: RangeValues(_minPrice, _maxPrice),
          min: 0,
          max: 1000,
          divisions: 10,
          labels: RangeLabels(
            _minPrice.toStringAsFixed(0),
            _maxPrice.toStringAsFixed(0),
          ),
          onChanged: (values) {
            setState(() {
              _minPrice = values.start;
              _maxPrice = values.end;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${_minPrice.toStringAsFixed(0)}'),
            Text('\$${_maxPrice.toStringAsFixed(0)}'),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Minimum Rating:'),
        Slider(
          value: _minRating,
          min: 0,
          max: 5,
          divisions: 5,
          label: _minRating.toStringAsFixed(1),
          onChanged: (value) {
            setState(() {
              _minRating = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('0'),
            Text('5'),
          ],
        ),
      ],
    );
  }
}