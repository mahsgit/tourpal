import 'package:flutter/material.dart';

class ServiceTabs extends StatelessWidget {
  const ServiceTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _ServiceTab(
            icon: Icons.hotel,
            label: 'Hotel',
            isSelected: true,
            onTap: () {},
          ),
          _ServiceTab(
            icon: Icons.flight,
            label: 'Flight',
            isSelected: false,
            onTap: () {},
          ),
          _ServiceTab(
            icon: Icons.directions_bus,
            label: 'Bus',
            isSelected: false,
            onTap: () {},
          ),
          _ServiceTab(
            icon: Icons.directions_boat,
            label: 'Boat',
            isSelected: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ServiceTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServiceTab({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
     

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

