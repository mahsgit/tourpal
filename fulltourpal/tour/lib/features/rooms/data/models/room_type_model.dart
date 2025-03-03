import '../../domain/entities/room_type.dart';

class RoomTypeModel extends RoomType {
  const RoomTypeModel({
    required String id,
    required String businessId,
    required String roomTypeName,
    required String description,
    required double price,
    required int noOfGuests,
    required List<String> media,
  }) : super(
          id: id,
          businessId: businessId,
          roomTypeName: roomTypeName,
          description: description,
          price: price,
          noOfGuests: noOfGuests,
          media: media,
        );

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) {
    return RoomTypeModel(
      id: json['_id'],
      businessId: json['businessId'],
      roomTypeName: json['roomTypeName'],
      description: json['description'],
      price: json['price'].toDouble(),
      noOfGuests: json['noOfGuests'],
      media: List<String>.from(json['media'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'businessId': businessId,
      'roomTypeName': roomTypeName,
      'description': description,
      'price': price,
      'noOfGuests': noOfGuests,
      'media': media,
    };
  }
}

