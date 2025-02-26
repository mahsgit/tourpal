import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/place_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_trending_place.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/search_places.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrendingPlaces getTrendingPlaces;
  final GetCategories getCategories;
  // final SearchPlaces searchPlaces;

  HomeBloc({
    required this.getTrendingPlaces,
    required this.getCategories,
    // required this.searchPlaces,
  }) : super(HomeInitial()) {
    on<LoadHomeContent>(_onLoadHomeContent);
    // on<SearchPlacesEvent>(_onSearchPlaces);
  }

  Future<void> _onLoadHomeContent(
    LoadHomeContent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final trendingPlacesResult = await getTrendingPlaces();
    final categoriesResult = await getCategories();

    await trendingPlacesResult.fold(
      (failure) async => emit(HomeError(failure.message)),
      (trendingPlaces) async {
        await categoriesResult.fold(
          (failure) async => emit(HomeError(failure.message)),
          (categories) async => emit(HomeLoaded(
            trendingPlaces: trendingPlaces,
            categories: categories,
          )),
        );
      },
    );
  }

  // Future<void> _onSearchPlaces(
  //   SearchPlacesEvent event,
  //   Emitter<HomeState> emit,
  // ) async {
  //   emit(HomeLoading());

  //   final result = await searchPlaces(event.query);

  //   result.fold(
  //     (failure) => emit(HomeError(failure.message)),
  //     (places) => emit(SearchResultsLoaded(places)),
  //   );
  // }
}

