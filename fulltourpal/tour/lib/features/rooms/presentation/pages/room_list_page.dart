import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../booking/presentation/bloc/booking_bloc.dart';
import '../../../booking/presentation/bloc/booking_event.dart';
import '../../../booking/presentation/bloc/booking_state.dart';
import '../../../booking/presentation/widgets/date_range_picker.dart';
import '../../domain/entities/room_type.dart';
import '../bloc/room_bloc.dart';
import '../widgets/room_card.dart';
import '../widgets/room_search_bar.dart';

class RoomListPage extends StatefulWidget {
  final String businessId;

  const RoomListPage({
    Key? key,
    required this.businessId,
  }) : super(key: key);

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  String _searchQuery = '';
  DateTime? _startDate;
  DateTime? _endDate;
  List<String> _availableRoomTypeIds = [];

  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(GetRoomTypesEvent(widget.businessId));
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    if (query.isEmpty) {
      context.read<RoomBloc>().add(GetRoomTypesEvent(widget.businessId));
    } else {
      context.read<RoomBloc>().add(SearchRoomTypesEvent(query));
    }
  }

  void _onDateRangeSelected(DateTime start, DateTime end) {
    setState(() {
      _startDate = start;
      _endDate = end;
    });
    
    context.read<BookingBloc>().add(
      GetAvailableRoomTypesEvent(
        businessId: widget.businessId,
        startDate: start,
        endDate: end,
      ),
    );
  }

  bool _isRoomAvailable(RoomType roomType) {
    if (_availableRoomTypeIds.isEmpty || _startDate == null || _endDate == null) {
      return true;
    }
    return _availableRoomTypeIds.contains(roomType.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rooms'),
      ),
      body: Column(
        children: [
          // Date Range Picker
          Padding(
            padding: const EdgeInsets.all(16),
            child: DateRangePicker(
              onDateRangeSelected: _onDateRangeSelected,
            ),
          ),
          
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RoomSearchBar(onSearch: _onSearch),
          ),
          
          // Available Room Types Listener
          BlocListener<BookingBloc, BookingState>(
            listener: (context, state) {
              if (state is AvailableRoomTypesLoaded) {
                setState(() {
                  _availableRoomTypeIds = state.roomTypeIds;
                });
              }
            },
            child: const SizedBox.shrink(),
          ),
          
          // Room List
          Expanded(
            child: BlocBuilder<RoomBloc, RoomState>(
              builder: (context, state) {
                if (state is RoomLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RoomTypesLoaded) {
                  final availableRooms = state.roomTypes
                      .where((room) => _isRoomAvailable(room))
                      .toList();
                  
                  if (availableRooms.isEmpty) {
                    return const Center(
                      child: Text('No rooms available for the selected dates'),
                    );
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: availableRooms.length,
                    itemBuilder: (context, index) {
                      return RoomCard(
                        roomType: availableRooms[index],
                        businessId: widget.businessId,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/room/details',
                            arguments: {
                              'roomType': availableRooms[index],
                              'businessId': widget.businessId,
                            },
                          );
                        },
                      );
                    },
                  );
                } else if (state is RoomError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

