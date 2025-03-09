import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../booking/presentation/bloc/booking_bloc.dart';
import '../../../booking/presentation/bloc/booking_event.dart';
import '../../../booking/presentation/bloc/booking_state.dart';
import '../../../booking/presentation/widgets/availability_display.dart';
import '../../domain/entities/room_type.dart';

class RoomCard extends StatelessWidget {
  final RoomType roomType;
  final String businessId;
  final VoidCallback? onTap;

  const RoomCard({
    Key? key,
    required this.roomType,
    required this.businessId,
    this.onTap,
  }) : super(key: key);

  void _showAvailabilityDialog(BuildContext context) {
    context.read<BookingBloc>().add(
          GetAvailableTimeRangesEvent(
            businessId: businessId,
            roomTypeId: roomType.id,
          ),
        );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Availability for ${roomType.roomTypeName}'),
          content: SizedBox(
            width: double.maxFinite,
            child: BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                if (state is BookingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AvailableTimeRangesLoaded) {
                  return AvailabilityDisplay(availabilities: state.availabilities);
                } else if (state is BookingError) {
                  return Text('Error: ${state.message}');
                }
                return const Text('Loading availability...');
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              if (roomType.media.isNotEmpty)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    roomType.media.first,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.hotel, size: 50),
                      );
                    },
                  ),
                )
              else
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const Icon(Icons.hotel, size: 50),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '\$${roomType.price.toStringAsFixed(0)}/night',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomType.roomTypeName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  roomType.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, size: 20),
                        const SizedBox(width: 4),
                        Text('${roomType.noOfGuests} Guests'),
                      ],
                    ),
                    Text(
                      '\$${roomType.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showAvailabilityDialog(context),
                        icon: const Icon(Icons.event_available),
                        label: const Text('Check Availability'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onTap,
                        icon: const Icon(Icons.book),
                        label: const Text('Book Now'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

