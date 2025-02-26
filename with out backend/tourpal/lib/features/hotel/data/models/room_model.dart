import '../../domain/entities/room_entity.dart';

class RoomModel extends RoomEntity {
  const RoomModel({
    required String id,
    required String name,
    required String imageUrl,
    required List<String> imageUrls,
    required double price,
    required int capacity,
    required bool isNonSmoking,
    required String description,
    required bool isAvailable,
    required List<String> amenities,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          imageUrls: imageUrls,
          price: price,
          capacity: capacity,
          isNonSmoking: isNonSmoking,
          description: description,
          isAvailable: isAvailable,
          amenities: amenities,
        );

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      imageUrls: List<String>.from(json['imageUrls']),
      price: json['price'].toDouble(),
      capacity: json['capacity'],
      isNonSmoking: json['isNonSmoking'],
      description: json['description'],
      isAvailable: json['isAvailable'],
      amenities: List<String>.from(json['amenities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'imageUrls': imageUrls,
      'price': price,
      'capacity': capacity,
      'isNonSmoking': isNonSmoking,
      'description': description,
      'isAvailable': isAvailable,
      'amenities': amenities,
    };
  }
}

