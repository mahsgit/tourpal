

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tourpal/features/hotel/presentation/pages/room_detail_page.dart';
// import '../bloc/hotel_bloc.dart';
// import '../widgets/room_card.dart';

// class RoomServicesPage extends StatelessWidget {
//   final String hotelId;

//   const RoomServicesPage({
//     Key? key,
//     required this.hotelId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Select Room'),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//       ),
//       body: BlocBuilder<HotelBloc, HotelState>(
//         builder: (context, state) {
//           if (state is HotelInitial) {
//             context.read<HotelBloc>().add(LoadHotelDetails(hotelId));
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is HotelLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is HotelDetailsLoaded) {
//             print("helooo");
//             return ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: state.hotel.rooms.length,
//               itemBuilder: (context, index) {
//                 final room = state.hotel.rooms[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 16),
//                   child: RoomCard(
//                     room: room,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RoomDetailsPage(
//                             hotelId: hotelId,
//                             room: room,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }

//           if (state is HotelError) {
//             return Center(child: Text(state.message));
//           }

//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tourpal/features/hotel/presentation/pages/room_detail_page.dart';
// import '../bloc/hotel_bloc.dart';
// import '../widgets/room_card.dart';

// class RoomServicesPage extends StatelessWidget {
//   final String hotelId;

//   const RoomServicesPage({
//     Key? key,
//     required this.hotelId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Select Room'),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//       ),
//       body: BlocBuilder<HotelBloc, HotelState>(
//         builder: (context, state) {
//           // Debugging: Print the current state
//           print('Current State: $state');

//           if (state is HotelInitial) {
//             context.read<HotelBloc>().add(LoadHotelDetails(hotelId));
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is HotelLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is HotelDetailsLoaded) {
//             // Debugging: Print the rooms list
//             print('Rooms: ${state.hotel.rooms}');

//             if (state.hotel.rooms.isEmpty) {
//               return const Center(child: Text('No rooms available.'));
//             }

//             return ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: state.hotel.rooms.length,
//               itemBuilder: (context, index) {
//                 final room = state.hotel.rooms[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 16),
//                   child: RoomCard(
//                     room: room,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RoomDetailsPage(
//                             hotelId: hotelId,
//                             room: room,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }

//           if (state is HotelError) {
//             return Center(child: Text(state.message));
//           }

//           // Default fallback
//           return const Center(child: Text('Unexpected state.'));
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourpal/features/hotel/presentation/pages/room_detail_page.dart';
import '../bloc/hotel_bloc.dart';
import '../widgets/room_card.dart';

class RoomServicesPage extends StatelessWidget {
  final String hotelId;

  const RoomServicesPage({
    Key? key,
    required this.hotelId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Select Room'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          print('Current State: $state');

          if (state is HotelInitial || state is HotelsLoaded) {
            context.read<HotelBloc>().add(LoadHotelDetails(hotelId));
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HotelLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HotelDetailsLoaded) {
            print('Rooms: ${state.hotel.rooms}');

            if (state.hotel.rooms.isEmpty) {
              return const Center(child: Text('No rooms available.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.hotel.rooms.length,
              itemBuilder: (context, index) {
                final room = state.hotel.rooms[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RoomCard(
                    room: room,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomDetailsPage(
                            hotelId: hotelId,
                            room: room,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          if (state is HotelError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text('Unexpected state.'));
        },
      ),
    );
  }
}

