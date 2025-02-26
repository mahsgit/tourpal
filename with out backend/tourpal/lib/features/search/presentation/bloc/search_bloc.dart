import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/place_entity.dart';
import '../../domain/usecases/search_places.dart';
import 'seach_event.dart' as search;

part 'search_state.dart';

class SearchBloc extends Bloc<search.SearchEvent, SearchState> {
  final SearchPlaces searchPlaces;

  SearchBloc({required this.searchPlaces}) : super(SearchInitial()) {
    on<search.SearchPlacesEvent>(_onSearchPlaces);
  }

  Future<void> _onSearchPlaces(
    search.SearchPlacesEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await searchPlaces(event.query);

    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (places) => emit(SearchLoaded(places)),
    );
  }
}