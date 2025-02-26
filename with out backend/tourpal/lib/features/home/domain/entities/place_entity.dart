import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String description;
  final String location;

  final double price;
  final bool isFavorite;

  const PlaceEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.price,
    required this.isFavorite,
    required this.location,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, rating, description, price, isFavorite];
}

