import '../../domain/entities/business_entity.dart';
import 'address_model.dart';

class BusinessModel extends BusinessEntity {
  const BusinessModel({
    required String id,
    required String businessName,
    required String email,
    required String phoneNumber,
    required AddressModel address,
    required String description,
    required double rating,
    required String businessType,
    required bool isVerified,
    required List<String> media,
    required DateTime createdAt,
    required DateTime updatedAt,
    required double price,
  }) : super(
          id: id,
          businessName: businessName,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
          description: description,
          rating: rating,
          businessType: businessType,
          isVerified: isVerified,
          media: media,
          createdAt: createdAt,
          updatedAt: updatedAt,
          price: price,
        );

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['_id'],
      businessName: json['businessName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: AddressModel.fromJson(json['address']),
      description: json['description'],
      rating: json['rating']?.toDouble() ?? 0.0,
      businessType: json['businessType'],
      isVerified: json['isVerified'] ?? false,
      media: List<String>.from(json['media'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      price: json['price']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'businessName': businessName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': (address as AddressModel).toJson(),
      'description': description,
      'rating': rating,
      'businessType': businessType,
      'isVerified': isVerified,
      'media': media,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

