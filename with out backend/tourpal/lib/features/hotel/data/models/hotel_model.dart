import '../../domain/entities/hotel_entity.dart';
import 'facility_model.dart';
import 'room_model.dart';

class HotelModel extends HotelEntity {
  const HotelModel({
    required String id,
    required String name,
    required String imageUrl,
    required List<String> imageUrls,
    required double rating,
    required int reviewCount,
    required String location,
    required String description,
    required double price,
    required bool isFavorite,
    required List<FacilityModel> facilities,
    required List<RoomModel> rooms,
    required double latitude,
    required double longitude,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          imageUrls: imageUrls,
          rating: rating,
          reviewCount: reviewCount,
          location: location,
          description: description,
          price: price,
          isFavorite: isFavorite,
          facilities: facilities,
          rooms: rooms,
          latitude: latitude,
          longitude: longitude,
        );

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      imageUrls: List<String>.from(json['imageUrls']),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      location: json['location'],
      description: json['description'],
      price: json['price'].toDouble(),
      isFavorite: json['isFavorite'] ?? false,
      facilities: (json['facilities'] as List)
          .map((facility) => FacilityModel.fromJson(facility))
          .toList(),
      rooms: (json['rooms'] as List)
          .map((room) => RoomModel.fromJson(room))
          .toList(),
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'imageUrls': imageUrls,
      'rating': rating,
      'reviewCount': reviewCount,
      'location': location,
      'description': description,
      'price': price,
      'isFavorite': isFavorite,
      'facilities': facilities
          .map((facility) => (facility as FacilityModel).toJson())
          .toList(),
      'rooms': rooms.map((room) => (room as RoomModel).toJson()).toList(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}