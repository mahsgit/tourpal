import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_bloc.dart';
import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_event.dart';
import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_state.dart';
import 'package:tourpal/features/trip_advisor/presentation/widget/preference_widget.dart';
import 'package:tourpal/features/trip_advisor/presentation/widget/trip_view.dart';

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
              onActivityEdit: (activity) {
                print('Updating activity: ${activity.name}'); // Debug print
                context.read<TripPlannerBloc>().add(UpdateActivityEvent(activity));
              },
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_bloc.dart';
// import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_event.dart';
// import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_state.dart';
// import 'package:tourpal/features/trip_advisor/presentation/widget/preference_widget.dart';
// import 'package:tourpal/features/trip_advisor/presentation/widget/trip_view.dart';

// class TripPlannerPage extends StatelessWidget {
//   final TripPlannerBloc bloc;

//   const TripPlannerPage({
//     Key? key,
//     required this.bloc,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: bloc,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plan Your Trip'),
//         ),
//         body: BlocBuilder<TripPlannerBloc, TripPlannerState>(
//           builder: (context, state) {
//             if (state is TripPlannerInitial) {
//               return PreferenceForm(
//                 onSubmit: (preferences) {
//                   context.read<TripPlannerBloc>().add(GenerateItineraryEvent(preferences));
//                 },
//               );
//             }

//             if (state is TripPlannerLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is TripPlannerSuccess) {
//               return ItineraryView(
//                 itinerary: state.itinerary,
//                 onActivityEdit: (activity) {
//                   // Handle activity edit
//                   context.read<TripPlannerBloc>().add(UpdateActivityEvent(activity));
//                 },
//               );
//             }

//             if (state is TripPlannerError) {
//               return Center(
//                 child: Text('Error: ${state.message}'),
//               );
//             }

//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }

