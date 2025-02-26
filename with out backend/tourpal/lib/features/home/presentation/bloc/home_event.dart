part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeContent extends HomeEvent {}

// class SearchPlacesEvent extends HomeEvent {
//   final String query;

//   const SearchPlacesEvent(this.query);

//   @override
//   List<Object> get props => [query];
// }

