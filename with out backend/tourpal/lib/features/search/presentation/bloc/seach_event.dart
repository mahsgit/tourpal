abstract class SearchEvent {}

class SearchPlacesEvent extends SearchEvent {
  final String query;

  SearchPlacesEvent(this.query);
}