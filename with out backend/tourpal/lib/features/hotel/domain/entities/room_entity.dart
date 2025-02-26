import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> imageUrls;
  final double price;
  final int capacity;
  final bool isNonSmoking;
  final String description;
  final bool isAvailable;
  final List<String> amenities;

  const RoomEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.imageUrls,
    required this.price,
    required this.capacity,
    required this.isNonSmoking,
    required this.description,
    required this.isAvailable,
    required this.amenities,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        imageUrls,
        price,
        capacity,
        isNonSmoking,
        description,
        isAvailable,
        amenities,
      ];
}

