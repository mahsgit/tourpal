import 'package:flutter/material.dart';
import '../../domain/entities/business_entity.dart';

class BookingConfirmationModal extends StatelessWidget {
  final BusinessEntity business;
  final DateTime checkIn;
  final DateTime checkOut;
  final int rooms;
  final VoidCallback onConfirm;

  const BookingConfirmationModal({
    Key? key,
    required this.business,
    required this.checkIn,
    required this.checkOut,
    required this.rooms,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Confirmation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(context, 'Hotel', business.businessName),
            _buildInfoRow(context, 'Check In', '${checkIn.day}/${checkIn.month}/${checkIn.year}'),
            _buildInfoRow(context, 'Check Out', '${checkOut.day}/${checkOut.month}/${checkOut.year}'),
            _buildInfoRow(context, 'Rooms', rooms.toString()),
            _buildInfoRow(context, 'Total Price', '${business.price * rooms} ETB'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirm,
                child: const Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

