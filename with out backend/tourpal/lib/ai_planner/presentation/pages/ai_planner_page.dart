import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/ai_planner_bloc.dart';
import '../bloc/ai_planner_event.dart';
import '../bloc/ai_planner_state.dart';
import '../widgets/preference_form.dart';
import '../widgets/itinerary_view.dart';

class AIPlannerPage extends StatelessWidget {
  const AIPlannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Trip Planner'),
      ),
      body: BlocConsumer<AIPlannerBloc, AIPlannerState>(
        listener: (context, state) {
          if (state is AIPlannerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AIPlannerInitial) {
            return PreferenceForm(
              onSubmit: (preferences) {
                context.read<AIPlannerBloc>().add(GenerateItineraryEvent(preferences));
              },
            );
          }

          if (state is AIPlannerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AIPlannerLoaded) {
            return ItineraryView(
              itinerary: state.itinerary,
              onActivityEdit: (dayPlanDay, oldActivity, newActivity) {
                context.read<AIPlannerBloc>().add(
                      UpdateActivityEvent(
                        dayPlanDay: dayPlanDay,
                        oldActivity: oldActivity,
                        newActivity: newActivity,
                      ),
                    );
              },
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}

