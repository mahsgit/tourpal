import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String address;
  final bool isPremium;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.isPremium,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, address, isPremium];
}

