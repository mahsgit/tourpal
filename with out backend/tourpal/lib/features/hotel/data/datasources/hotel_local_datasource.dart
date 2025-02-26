// import 'package:tourpal/features/hotel/data/models/facility_model.dart';
// import 'package:tourpal/features/hotel/data/models/hotel_model.dart';
// import 'package:tourpal/features/hotel/data/models/room_model.dart';


// abstract class HotelLocalDataSource {
//   Future<List<HotelModel>> getHotels();
//   Future<HotelModel> getHotelDetails(String id);
//   Future<void> toggleFavorite(String id);
// }

// class HotelLocalDataSourceImpl implements HotelLocalDataSource {
//   final List<HotelModel> _hotels = [
//     HotelModel(
//       id: '1',
//       name: 'Holy Park Hotel',
//       imageUrl: 'https://picsum.photos/200/300?1',
//       imageUrls: [
//         'https://picsum.photos/200/300?1',
//         'https://picsum.photos/200/300?2',
//         'https://picsum.photos/200/300?3',
//       ],
//       rating: 4.8,
//       reviewCount: 150,
//       location: "Cox's Bazar",
//       description: 'Luxury hotel with ocean view rooms and premium amenities.',
//       price: 89,
//       isFavorite: true,
//       facilities: [
//          FacilityModel(id: '1', name: 'Free WiFi', icon: '📶'),
//          FacilityModel(id: '2', name: 'Pool', icon: '🏊‍♂️'),
//          FacilityModel(id: '3', name: 'Breakfast', icon: '🍳'),
//          FacilityModel(id: '4', name: 'Lunch', icon: '🍽️'),
//       ],
//       rooms: [
//         RoomModel(
//           id: '1',
//           name: 'Deluxe Double Bed With Balcony',
//           imageUrl: 'https://picsum.photos/200/300?4',
//           imageUrls: [
//             'https://picsum.photos/200/300?4',
//             'https://picsum.photos/200/300?5',
//           ],
//           price: 85,
//           capacity: 2,
//           isNonSmoking: true,
//           description: 'Spacious room with ocean view balcony',
//           isAvailable: true,
//           amenities: ['WiFi', 'TV', 'Mini Bar', 'Safe'],
//         ),
//       ],
//       latitude: 21.4272,
//       longitude: 92.0058,
 
//     ),
//     // Add more hotels...
//   ];

//   @override
//   Future<List<HotelModel>> getHotels() async {
//     await Future.delayed(const Duration(seconds: 1));
//     return _hotels;
//   }

//   @override
//   Future<HotelModel> getHotelDetails(String id) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return _hotels.firstWhere((hotel) => hotel.id == id);
//   }

//   @override
//   Future<void> toggleFavorite(String id) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     final index = _hotels.indexWhere((hotel) => hotel.id == id);
//     if (index != -1) {
//       final hotel = _hotels[index];
//       _hotels[index] = HotelModel(
//         id: hotel.id,
//         name: hotel.name,
//         imageUrl: hotel.imageUrl,
//         imageUrls: hotel.imageUrls,
//         rating: hotel.rating,
//         reviewCount: hotel.reviewCount,
//         location: hotel.location,
//         description: hotel.description,
//         price: hotel.price,
//         isFavorite: !hotel.isFavorite,
//         facilities: hotel.facilities.cast<FacilityModel>().toList(),
//         rooms: hotel.rooms.cast<RoomModel>().toList(),
//         latitude: hotel.latitude,
//         longitude: hotel.longitude,
//       );
//     }
//   }
// }

import '../models/hotel_model.dart';
import '../models/facility_model.dart';
import '../models/room_model.dart';

abstract class HotelLocalDataSource {
  Future<List<HotelModel>> getHotels();
  Future<HotelModel> getHotelDetails(String id);
  Future<void> toggleFavorite(String id);
}

class HotelLocalDataSourceImpl implements HotelLocalDataSource {
  final List<HotelModel> _hotels = [
    HotelModel(
      id: '1',
      name: 'Holy Park Hotel',
      imageUrl: 'https://picsum.photos/200/300?1',
      imageUrls: [
        'https://picsum.photos/200/300?1',
        'https://picsum.photos/200/300?2',
        'https://picsum.photos/200/300?3',
      ],
      rating: 4.8,
      reviewCount: 150,
      location: "Cox's Bazar",
      description: 'Luxury hotel with ocean view rooms and premium amenities.',
      price: 89,
      isFavorite: true,
      facilities: [
         FacilityModel(id: '1', name: 'Free WiFi', icon: '📶'),
         FacilityModel(id: '2', name: 'Pool', icon: '🏊‍♂️'),
         FacilityModel(id: '3', name: 'Breakfast', icon: '🍳'),
         FacilityModel(id: '4', name: 'Lunch', icon: '🍽️'),
      ],
      rooms: [
        RoomModel(
          id: '1',
          name: 'Deluxe Double Bed With Balcony',
          imageUrl: 'https://picsum.photos/200/300?4',
          imageUrls: [
            'https://picsum.photos/200/300?4',
            'https://picsum.photos/200/300?5',
          ],
          price: 85,
          capacity: 2,
          isNonSmoking: true,
          description: 'Spacious room with ocean view balcony',
          isAvailable: true,
          amenities: ['WiFi', 'TV', 'Mini Bar', 'Safe'],
        ),
      ],
      latitude: 21.4272,
      longitude: 92.0058,
      // panoramaImages: [
      //   'assets/panorama/hotel1_1.jpg',
      //   'assets/panorama/hotel1_2.jpg',
      // ],
    ),
    HotelModel(
      id: '2',
      name: 'Dream Valley',
      imageUrl: 'https://picsum.photos/200/300?6',
      imageUrls: [
        'https://picsum.photos/200/300?6',
        'https://picsum.photos/200/300?7',
      ],
      rating: 4.8,
      reviewCount: 120,
      location: 'Dhaka',
      description: 'Modern hotel in the heart of the city with luxury amenities.',
      price: 89,
      isFavorite: false,
      facilities: [
         FacilityModel(id: '1', name: 'Free WiFi', icon: '📶'),
         FacilityModel(id: '2', name: 'Gym', icon: '💪'),
         FacilityModel(id: '3', name: 'Spa', icon: '💆‍♂️'),
      ],
      rooms: [
        RoomModel(
          id: '1',
          name: 'Deluxe Double Bed With Balcony',
          imageUrl: 'https://picsum.photos/200/300?8',
          imageUrls: [
            'https://picsum.photos/200/300?8',
            'https://picsum.photos/200/300?9',
          ],
          price: 85,
          capacity: 2,
          isNonSmoking: true,
          description: 'Modern room with city view',
          isAvailable: true,
          amenities: ['WiFi', 'TV', 'Mini Bar', 'Safe'],
        ),
      ],
      latitude: 23.8103,
      longitude: 90.4125,
      // panoramaImages: [
      //   'assets/panorama/hotel2_1.jpg',
      //   'assets/panorama/hotel2_2.jpg',
      // ],
    ),
    HotelModel(
      id: '3',
      name: 'Esha Hotel',
      imageUrl: 'https://picsum.photos/200/300?10',
      imageUrls: [
        'https://picsum.photos/200/300?10',
        'https://picsum.photos/200/300?11',
      ],
      rating: 4.8,
      reviewCount: 90,
      location: 'Chittagong',
      description: 'Boutique hotel with personalized service.',
      price: 89,
      isFavorite: false,
      facilities: [
         FacilityModel(id: '1', name: 'Free WiFi', icon: '📶'),
         FacilityModel(id: '2', name: 'Restaurant', icon: '🍽️'),
         FacilityModel(id: '3', name: 'Bar', icon: '🍷'),
      ],
      rooms: [
        RoomModel(
          id: '1',
          name: 'Deluxe Double Bed With Balcony',
          imageUrl: 'https://picsum.photos/200/300?12',
          imageUrls: [
            'https://picsum.photos/200/300?12',
            'https://picsum.photos/200/300?13',
          ],
          price: 85,
          capacity: 2,
          isNonSmoking: true,
          description: 'Elegant room with modern amenities',
          isAvailable: true,
          amenities: ['WiFi', 'TV', 'Mini Bar', 'Safe'],
        ),
      ],
      latitude: 22.3569,
      longitude: 91.7832,
      // panoramaImages: [
      //   'assets/panorama/hotel3_1.jpg',
      //   'assets/panorama/hotel3_2.jpg',
      // ],
    ),
    HotelModel(
      id: '4',
      name: 'Hotel Niribili',
      imageUrl: 'https://picsum.photos/200/300?14',
      imageUrls: [
        'https://picsum.photos/200/300?14',
        'https://picsum.photos/200/300?15',
      ],
      rating: 4.8,
      reviewCount: 75,
      location: "Cox's Bazar",
      description: 'Beachfront hotel with stunning views.',
      price: 89,
      isFavorite: false,
      facilities: [
         FacilityModel(id: '1', name: 'Free WiFi', icon: '📶'),
         FacilityModel(id: '2', name: 'Beach Access', icon: '🏖️'),
         FacilityModel(id: '3', name: 'Pool', icon: '🏊‍♂️'),
      ],
      rooms: [
        RoomModel(
          id: '1',
          name: 'Deluxe Double Bed With Balcony',
          imageUrl: 'https://picsum.photos/200/300?16',
          imageUrls: [
            'https://picsum.photos/200/300?16',
            'https://picsum.photos/200/300?17',
          ],
          price: 85,
          capacity: 2,
          isNonSmoking: true,
          description: 'Room with private balcony and sea view',
          isAvailable: true,
          amenities: ['WiFi', 'TV', 'Mini Bar', 'Safe'],
        ),
      ],
      latitude: 21.4272,
      longitude: 92.0058,
      // panoramaImages: [
      //   'assets/panorama/hotel4_1.jpg',
      //   'assets/panorama/hotel4_2.jpg',
      // ],
    ),
    HotelModel(
      id: '5',
      name: 'Luxury Hotel',
      imageUrl: 'https://picsum.photos/200/300?18',
      imageUrls: [
        'https://picsum.photos/200/300?18',
        'https://picsum.photos/200/300?19',
      ],
      rating: 4.8,
      reviewCount: 200,
      location: 'Dhaka',
      description: 'Five-star luxury hotel in prime location.',
      price: 89,
      isFavorite: false,
      facilities: [
         FacilityModel(id: '1', name: 'Free WiFi', icon: '📶'),
         FacilityModel(id: '2', name: 'Spa', icon: '💆‍♂️'),
         FacilityModel(id: '3', name: 'Pool', icon: '🏊‍♂️'),
         FacilityModel(id: '4', name: 'Gym', icon: '💪'),
      ],
      rooms: [
        RoomModel(
          id: '1',
          name: 'Deluxe Double Bed With Balcony',
          imageUrl: 'https://picsum.photos/200/300?20',
          imageUrls: [
            'https://picsum.photos/200/300?20',
            'https://picsum.photos/200/300?21',
          ],
          price: 85,
          capacity: 2,
          isNonSmoking: true,
          description: 'Luxurious room with premium amenities',
          isAvailable: true,
          amenities: ['WiFi', 'TV', 'Mini Bar', 'Safe'],
        ),
      ],
      latitude: 23.8103,
      longitude: 90.4125,
      // panoramaImages: [
      //   'assets/panorama/hotel5_1.jpg',
      //   'assets/panorama/hotel5_2.jpg',
      // ],
    ),
  ];

  @override
  Future<List<HotelModel>> getHotels() async {
    await Future.delayed(const Duration(seconds: 1));
    return _hotels;
  }

  @override
  Future<HotelModel> getHotelDetails(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _hotels.firstWhere((hotel) => hotel.id == id);
  }

  @override
  Future<void> toggleFavorite(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _hotels.indexWhere((hotel) => hotel.id == id);
    if (index != -1) {
      final hotel = _hotels[index];
      _hotels[index] = HotelModel(
        id: hotel.id,
        name: hotel.name,
        imageUrl: hotel.imageUrl,
        imageUrls: hotel.imageUrls,
        rating: hotel.rating,
        reviewCount: hotel.reviewCount,
        location: hotel.location,
        description: hotel.description,
        price: hotel.price,
        isFavorite: !hotel.isFavorite,
        facilities: hotel.facilities.cast<FacilityModel>().toList(),
        rooms: hotel.rooms.cast<RoomModel>().toList(),
        latitude: hotel.latitude,
        longitude: hotel.longitude,
      );
    }
  }
}

