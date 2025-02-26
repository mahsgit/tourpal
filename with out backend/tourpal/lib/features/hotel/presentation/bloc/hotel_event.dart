// part of 'hotel_bloc.dart';

// abstract class HotelEvent extends Equatable {
//   const HotelEvent();

//   @override
//   List<Object> get props => [];
// }

// class LoadHotels extends HotelEvent {}

// class LoadHotelDetails extends HotelEvent {
//   final String id;

//   const LoadHotelDetails(this.id);

//   @override
//   List<Object> get props => [id];
// }

part of 'hotel_bloc.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object> get props => [];
}

class LoadHotels extends HotelEvent {}

class LoadHotelDetails extends HotelEvent {
  final String id;

  const LoadHotelDetails(this.id);

  @override
  List<Object> get props => [id];
}

class SearchHotels extends HotelEvent {
  final String query;

  const SearchHotels(this.query);

  @override
  List<Object> get props => [query];
}

