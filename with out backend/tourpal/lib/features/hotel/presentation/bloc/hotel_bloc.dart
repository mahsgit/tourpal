// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:tourpal/features/hotel/domain/usecases/get_hotel.dart';
// import '../../domain/entities/hotel_entity.dart';
// import '../../domain/usecases/get_hotel_details.dart';

// part 'hotel_event.dart';
// part 'hotel_state.dart';

// class HotelBloc extends Bloc<HotelEvent, HotelState> {
//   final GetHotels getHotels;
//   final GetHotelDetails getHotelDetails;

//   HotelBloc({
//     required this.getHotels,
//     required this.getHotelDetails,
//   }) : super(HotelInitial()) {
//     on<LoadHotels>(_onLoadHotels);
//     on<LoadHotelDetails>(_onLoadHotelDetails);
//   }

//   Future<void> _onLoadHotels(
//     LoadHotels event,
//     Emitter<HotelState> emit,
//   ) async {
//     emit(HotelLoading());

//     final result = await getHotels();

//     result.fold(
//       (failure) => emit(HotelError(failure.message)),
//       (hotels) => emit(HotelsLoaded(hotels)),
//     );
//   }

//   Future<void> _onLoadHotelDetails(
//     LoadHotelDetails event,
//     Emitter<HotelState> emit,
//   ) async {
//     emit(HotelLoading());

//     final result = await getHotelDetails(event.id);

//     result.fold(
//       (failure) => emit(HotelError(failure.message)),
//       (hotel) => emit(HotelDetailsLoaded(hotel)),
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourpal/features/hotel/domain/usecases/get_hotel.dart';
import '../../domain/entities/hotel_entity.dart';
import '../../domain/usecases/get_hotel_details.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final GetHotels getHotels;
  final GetHotelDetails getHotelDetails;
  List<HotelEntity> _allHotels = [];

  HotelBloc({
    required this.getHotels,
    required this.getHotelDetails,
  }) : super(HotelInitial()) {
    on<LoadHotels>(_onLoadHotels);
    on<LoadHotelDetails>(_onLoadHotelDetails);
    on<SearchHotels>(_onSearchHotels);
  }

  Future<void> _onLoadHotels(
    LoadHotels event,
    Emitter<HotelState> emit,
  ) async {
    emit(HotelLoading());

    final result = await getHotels();

    result.fold(
      (failure) => emit(HotelError(failure.message)),
      (hotels) {
        _allHotels = hotels;
        emit(HotelsLoaded(hotels));
      },
    );
  }

  Future<void> _onLoadHotelDetails(
    LoadHotelDetails event,
    Emitter<HotelState> emit,
  ) async {
    emit(HotelLoading());

    final result = await getHotelDetails(event.id);

    result.fold(
      (failure) => emit(HotelError(failure.message)),
      (hotel) => emit(HotelDetailsLoaded(hotel)),
    );
  }

  void _onSearchHotels(
    SearchHotels event,
    Emitter<HotelState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(HotelsLoaded(_allHotels));
      return;
    }

    final searchResults = _allHotels.where((hotel) {
      final name = hotel.name.toLowerCase();
      final location = hotel.location.toLowerCase();
      final query = event.query.toLowerCase();
      return name.contains(query) || location.contains(query);
    }).toList();

    emit(HotelsLoaded(searchResults));
  }
}

