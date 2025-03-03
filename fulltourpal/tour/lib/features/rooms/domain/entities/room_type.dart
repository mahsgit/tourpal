import 'package:equatable/equatable.dart';

class RoomType extends Equatable {
  final String id;
  final String businessId;
  final String roomTypeName;
  final String description;
  final double price;
  final int noOfGuests;
  final List<String> media;

  const RoomType({
    required this.id,
    required this.businessId,
    required this.roomTypeName,
    required this.description,
    required this.price,
    required this.noOfGuests,
    required this.media,
  });

  @override
  List<Object?> get props => [
        id,
        businessId,
        roomTypeName,
        description,
        price,
        noOfGuests,
        media,
      ];
}

