import '../../domain/entities/place_entity.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required String id,
    required String name,
    required String imageUrl,
    required double rating,
    required String description,
    required double price,
    required bool isFavorite,
    required  String location,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          rating: rating,
          description: description,
          price: price,
          isFavorite: isFavorite,
          location: location
        );

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      description: json['description'],
      price: json['price'].toDouble(),
      isFavorite: json['isFavorite'] ?? false,
      location: json['location']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'rating': rating,
      'description': description,
      'price': price,
      'isFavorite': isFavorite,
    };
  }
}

