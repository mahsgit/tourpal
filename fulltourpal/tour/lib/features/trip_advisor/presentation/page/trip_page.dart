import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour/features/trip_advisor/presentation/widget/preference_widget.dart';
import 'package:tour/features/trip_advisor/presentation/widget/trip_view.dart';
import '../bloc/trip_bloc.dart';
import '../bloc/trip_event.dart';
import '../bloc/trip_state.dart';

class TripPlannerPage extends StatelessWidget {
  const TripPlannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Your Trip'),
      ),
      body: BlocConsumer<TripPlannerBloc, TripPlannerState>(
        listener: (context, state) {
          if (state is TripPlannerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is TripPlannerInitial) {
            return PreferenceForm(
              onSubmit: (preferences) {
                context.read<TripPlannerBloc>().add(GenerateItineraryEvent(preferences));
              },
            );
          }

          if (state is TripPlannerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TripPlannerSuccess) {
            return ItineraryView(
              itinerary: state.itinerary,
              onActivityEdit: (updatedActivity) {
                print('Updating activity: ${updatedActivity.name}'); // Debug print
                context.read<TripPlannerBloc>().add(UpdateActivityEvent(updatedActivity));
              },
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}

