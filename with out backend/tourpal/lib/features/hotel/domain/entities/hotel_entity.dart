import 'package:equatable/equatable.dart';
import 'room_entity.dart';
import 'facility_entity.dart';

class HotelEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> imageUrls;
  final double rating;
  final int reviewCount;
  final String location;
  final String description;
  final double price;
  final bool isFavorite;
  final List<FacilityEntity> facilities;
  final List<RoomEntity> rooms;
  final double latitude;
  final double longitude;
  // final List<String> panoramaImages;

  const HotelEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.imageUrls,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.description,
    required this.price,
    required this.isFavorite,
    required this.facilities,
    required this.rooms,
    required this.latitude,
    required this.longitude,
    // required this.panoramaImages,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        imageUrls,
        rating,
        reviewCount,
        location,
        description,
        price,
        isFavorite,
        facilities,
        rooms,
        latitude,
        longitude,
      ];
}

