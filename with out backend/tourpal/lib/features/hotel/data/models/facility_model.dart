import '../../domain/entities/facility_entity.dart';

class FacilityModel extends FacilityEntity {
  final String id;
  final String name;
  final String icon;

  FacilityModel({
    required this.id,
    required this.name,
    required this.icon,
  }) : super(id: id, name: name, icon: icon);

  factory FacilityModel.fromJson(Map<String, dynamic> json) {
    return FacilityModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}