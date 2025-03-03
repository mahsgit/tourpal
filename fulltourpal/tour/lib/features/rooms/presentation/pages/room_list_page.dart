import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rooms'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: RoomSearchBar(onSearch: _onSearch),
          ),
          Expanded(
            child: BlocBuilder<RoomBloc, RoomState>(
              builder: (context, state) {
                if (state is RoomLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RoomTypesLoaded) {
                  if (state.roomTypes.isEmpty) {
                    return const Center(
                      child: Text('No rooms available'),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.roomTypes.length,
                    itemBuilder: (context, index) {
                      return RoomCard(
                        roomType: state.roomTypes[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/room/details',
                            arguments: state.roomTypes[index].id,
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

