import 'package:equatable/equatable.dart';

class FacilityEntity extends Equatable {
  final String id;
  final String name;
  final String icon;

  const FacilityEntity({
    required this.id,
    required this.name,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, name, icon];
}

