import 'package:flutter/material.dart';

class BookingBottomSheet extends StatelessWidget {
  const BookingBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Text(
            'Book With',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _BookingOption(
            icon: Icons.home,
            title: 'TourPal',
            subtitle: 'Best prices and exclusive deals',
            onTap: () {
              Navigator.pop(context);
              // Handle TourPal booking
            },
          ),
          const Divider(),
          _BookingOption(
            icon: Icons.bed,
            title: 'Booking.com',
            subtitle: 'Compare rates and availability',
            onTap: () {
              Navigator.pop(context);
              // Handle Booking.com redirect
            },
          ),
          const Divider(),
          _BookingOption(
            icon: Icons.card_travel,
            title: 'Travel',
            subtitle: 'Special offers for members',
            onTap: () {
              Navigator.pop(context);
              // Handle Travel booking
            },
          ),
        ],
      ),
    );
  }
}

class _BookingOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BookingOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}

