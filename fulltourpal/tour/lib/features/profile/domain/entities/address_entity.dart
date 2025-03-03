import 'package:equatable/equatable.dart';
import 'package:tour/features/profile/data/models/address_model.dart';

class AddressEntity extends Equatable {
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  const AddressEntity({
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  @override
  List<Object?> get props => [street, city, state, postalCode, country];

AddressModel toModel() {
    return AddressModel(
      street: street,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country,
    );
  }

}


