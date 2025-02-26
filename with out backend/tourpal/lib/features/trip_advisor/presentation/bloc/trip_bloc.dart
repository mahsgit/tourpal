
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourpal/features/trip_advisor/domain/entity/trip_entity.dart';
import 'package:tourpal/features/trip_advisor/domain/entity/trip_preference.dart';
import 'package:tourpal/features/trip_advisor/domain/usecase/gemini_usecase.dart';
import 'package:tourpal/features/trip_advisor/domain/repository/trip_repo.dart';
import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_event.dart';
import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_state.dart';


class TripPlannerBloc extends Bloc<TripPlannerEvent, TripPlannerState> {
  final GenerateItinerary generateItineraryUseCase;
  final ItineraryRepository repository;

  TripPlannerBloc({
    required this.generateItineraryUseCase,
    required this.repository,
  }) : super(TripPlannerInitial()) {
    on<GenerateItineraryEvent>(_onGenerateItinerary);
    on<UpdateActivityEvent>(_onUpdateActivity);
  }

Future<void> _onGenerateItinerary(
  GenerateItineraryEvent event,
  Emitter<TripPlannerState> emit,
) async {
  emit(TripPlannerLoading());
  try {
    final itinerary = await generateItineraryUseCase(event.preferences);
    if (itinerary.days.isEmpty) {
      throw Exception('Received empty itinerary from server');
    }
    emit(TripPlannerSuccess(itinerary));
  } catch (e) {
    print('Error generating itinerary: $e');
    emit(TripPlannerError(e.toString()));
  }
}

  Future<void> _onUpdateActivity(
    UpdateActivityEvent event,
    Emitter<TripPlannerState> emit,
  ) async {
    try {
      if (state is TripPlannerSuccess) {
        final currentItinerary = (state as TripPlannerSuccess).itinerary;
        final updatedItinerary = _updateActivityInItinerary(currentItinerary, event.activity);
        final savedItinerary = await repository.updateItinerary(updatedItinerary);
        emit(TripPlannerSuccess(savedItinerary));
      }
    } catch (e) {
      emit(TripPlannerError(e.toString()));
    }
  }

  Itinerary _updateActivityInItinerary(Itinerary itinerary, Activity updatedActivity) {
    final updatedDays = itinerary.days.map((day) {
      final updatedActivities = day.activities.map((activity) {
        return activity.id == updatedActivity.id ? updatedActivity : activity;
      }).toList();
      return DayPlan(id: day.id, dayNumber: day.dayNumber, activities: updatedActivities);
    }).toList();

    return Itinerary(
      id: itinerary.id,
      days: updatedDays,
      preferences: itinerary.preferences,
    );
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tourpal/features/trip_advisor/domain/usecase/gemini_usecase.dart';
// import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_event.dart';
// import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_state.dart';


// class TripPlannerBloc extends Bloc<TripPlannerEvent, TripPlannerState> {
//   final GenerateItinerary generateItinerary;

//   TripPlannerBloc({required this.generateItinerary}) : super(TripPlannerInitial()) {
//     on<GenerateItineraryEvent>(_onGenerateItinerary);
//     on<UpdateActivityEvent>(_onUpdateActivity);
//   }

//   Future<void> _onGenerateItinerary(
//     GenerateItineraryEvent event,
//     Emitter<TripPlannerState> emit,
//   ) async {
//     emit(TripPlannerLoading());
//     try {
//       final itinerary = await generateItinerary(event.preferences);
//       emit(TripPlannerSuccess(itinerary));
//     } catch (e) {
//       emit(TripPlannerError(e.toString()));
//     }
//   }

//   Future<void> _onUpdateActivity(
//     UpdateActivityEvent event,
//     Emitter<TripPlannerState> emit,
//   ) async {
//     try {
//       if (state is TripPlannerSuccess) {
//         final currentItinerary = (state as TripPlannerSuccess).itinerary;
//         // Update the activity in the itinerary
//         // Implementation details...
//         emit(TripPlannerSuccess(currentItinerary));
//       }
//     } catch (e) {
//       emit(TripPlannerError(e.toString()));
//     }
//   }
// }

