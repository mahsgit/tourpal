import 'package:equatable/equatable.dart';

class Availability extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const Availability({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

