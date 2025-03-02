import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour/features/ai_planner/domain/entities/itinerary.dart';
import '../../domain/usecases/generate_itinerary.dart';
import 'ai_planner_event.dart';
import 'ai_planner_state.dart';

class AIPlannerBloc extends Bloc<AIPlannerEvent, AIPlannerState> {
  final GenerateItinerary generateItinerary;

  AIPlannerBloc({required this.generateItinerary}) : super(AIPlannerInitial()) {
    on<GenerateItineraryEvent>(_onGenerateItinerary);
    on<UpdateActivityEvent>(_onUpdateActivity);
  }

  Future<void> _onGenerateItinerary(
    GenerateItineraryEvent event,
    Emitter<AIPlannerState> emit,
  ) async {
    emit(AIPlannerLoading());
    final result = await generateItinerary(event.preferences);
    result.fold(
      (failure) => emit(AIPlannerError(message: 'Failed to generate itinerary')),
      (itinerary) => emit(AIPlannerLoaded(itinerary: itinerary)),
    );
  }

  void _onUpdateActivity(
    UpdateActivityEvent event,
    Emitter<AIPlannerState> emit,
  ) {
    if (state is AIPlannerLoaded) {
      final currentState = state as AIPlannerLoaded;
      final updatedDaysPlan = currentState.itinerary.daysPlan.map((dayPlan) {
        if (dayPlan.day == event.dayPlanDay) {
          final updatedActivities = dayPlan.activities.map((activity) {
            if (activity == event.oldActivity) {
              return event.newActivity;
            }
            return activity;
          }).toList();
          return DayPlan(day: dayPlan.day, activities: updatedActivities);
        }
        return dayPlan;
      }).toList();

      final updatedItinerary = Itinerary(
        daysPlan: updatedDaysPlan,
        topPlacesToVisit: currentState.itinerary.topPlacesToVisit,
        topRestaurantsToTry: currentState.itinerary.topRestaurantsToTry,
        topActivitiesToDo: currentState.itinerary.topActivitiesToDo,
        packingChecklist: currentState.itinerary.packingChecklist,
      );

      emit(AIPlannerLoaded(itinerary: updatedItinerary));
    }
  }
}

