import 'package:equatable/equatable.dart';
import 'address_entity.dart';

class BusinessEntity extends Equatable {
  final String id;
  final String businessName;
  final String email;
  final String phoneNumber;
  final AddressEntity address;
  final String description;
  final double rating;
  final String businessType;
  final bool isVerified;
  final List<String> media;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BusinessEntity({
    required this.id,
    required this.businessName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.description,
    required this.rating,
    required this.businessType,
    required this.isVerified,
    required this.media,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        businessName,
        email,
        phoneNumber,
        address,
        description,
        rating,
        businessType,
        isVerified,
        media,
        createdAt,
        updatedAt,
      ];
}

