part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PlaceEntity> trendingPlaces;
  final List<CategoryEntity> categories;

  const HomeLoaded({
    required this.trendingPlaces,
    required this.categories,
  });

  @override
  List<Object> get props => [trendingPlaces, categories];
}

// class SearchResultsLoaded extends HomeState {
//   final List<PlaceEntity> places;

//   const SearchResultsLoaded(this.places);

//   @override
//   List<Object> get props => [places];
// }

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

