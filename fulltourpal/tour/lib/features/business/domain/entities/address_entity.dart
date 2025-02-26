import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  const AddressEntity({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  @override
  List<Object?> get props => [street, city, state, postalCode, country];
}

