import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../booking/domain/entities/booking.dart';
import '../../../booking/presentation/bloc/booking_bloc.dart';
import '../../../booking/presentation/bloc/booking_event.dart';
import '../../../booking/presentation/bloc/booking_state.dart';
import '../../../booking/presentation/widgets/date_range_picker.dart';
import '../../domain/entities/room_type.dart';

class RoomDetailsPage extends StatefulWidget {
  final RoomType roomType;
  final String businessId;

  const RoomDetailsPage({
    Key? key,
    required this.roomType,
    required this.businessId,
  }) : super(key: key);

  @override
  State<RoomDetailsPage> createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  DateTime? _startDate;
  DateTime? _endDate;

  void _onDateRangeSelected(DateTime start, DateTime end) {
    setState(() {
      _startDate = start;
      _endDate = end;
    });
  }

  void _reserveRoom() {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select check-in and check-out dates')),
      );
      return;
    }

    // TODO: Replace with actual user ID from auth
    const userId = 'user123';

    final booking = Booking(
      id: '',
      userId: userId,
      roomId: widget.roomType.id,
      startDate: _startDate!,
      endDate: _endDate!,
    );

    context.read<BookingBloc>().add(ReserveBookingEvent(booking: booking));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomType.roomTypeName),
      ),
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingReserved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Booking successful!')),
            );
            Navigator.pop(context);
          } else if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Image
              Stack(
                children: [
                  if (widget.roomType.media.isNotEmpty)
                    Image.network(
                      widget.roomType.media.first,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(Icons.hotel, size: 80),
                        );
                      },
                    )
                  else
                    Container(
                      height: 250,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.hotel, size: 80),
                    ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Text(
                        widget.roomType.roomTypeName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Room Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price and Guests
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.roomType.price}/night',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.roomType.noOfGuests} Guests',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    
                    // Description
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(widget.roomType.description),
                    const SizedBox(height: 24),
                    
                    // Date Range Picker
                    DateRangePicker(
                      onDateRangeSelected: _onDateRangeSelected,
                    ),
                    const SizedBox(height: 16),
                    
                    // Booking Summary
                    if (_startDate != null && _endDate != null)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Booking Summary',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Room:'),
                                  Text(widget.roomType.roomTypeName),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Price per night:'),
                                  Text('\$${widget.roomType.price}'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Number of nights:'),
                                  Text('${_endDate!.difference(_startDate!).inDays}'),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total:',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$${(widget.roomType.price * _endDate!.difference(_startDate!).inDays).toStringAsFixed(2)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    
                    // Reserve Button
                    BlocBuilder<BookingBloc, BookingState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state is BookingLoading ? null : _reserveRoom,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: state is BookingLoading
                                ? const CircularProgressIndicator()
                                : const Text('Reserve Now'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

