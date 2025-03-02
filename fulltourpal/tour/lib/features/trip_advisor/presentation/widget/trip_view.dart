import 'package:flutter/material.dart';
import 'package:tour/features/trip_advisor/domain/entity/trip_entity.dart';
import 'package:tour/features/trip_advisor/presentation/widget/activity.dart';
import 'package:tour/features/trip_advisor/presentation/widget/edit.dart';

class ItineraryView extends StatelessWidget {
  final Itinerary itinerary;
  final Function(Activity) onActivityEdit;

  const ItineraryView({
    Key? key,
    required this.itinerary,
    required this.onActivityEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itinerary.days.length,
      itemBuilder: (context, index) {
        final day = itinerary.days[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Day ${day.dayNumber}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...day.activities.map((activity) {
              return ActivityCard(
                activity: activity,
                // In the onEdit callback:
onEdit: () async {
  final updatedActivity = await showDialog<Activity>(
    context: context,
    builder: (context) => EditActivityDialog(activity: activity),
  );
  
  if (updatedActivity != null) {
    onActivityEdit(updatedActivity);
  }
},
              );
            }).toList(),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:tour/features/trip_advisor/domain/entity/trip_entity.dart';
// import 'package:tour/features/trip_advisor/presentation/widget/activity.dart';


// class ItineraryView extends StatelessWidget {
//   final Itinerary itinerary;
//   final Function(Activity) onActivityEdit;

//   const ItineraryView({
//     Key? key,
//     required this.itinerary,
//     required this.onActivityEdit,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: itinerary.days.length,
//       itemBuilder: (context, index) {
//         final day = itinerary.days[index];
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Text(
//                 'Day ${day.dayNumber}',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             ...day.activities.map((activity) {
//               return ActivityCard(
//                 activity: activity,
//                 onEdit: () => onActivityEdit(activity),
//               );
//             }).toList(),
//             const SizedBox(height: 16),
//           ],
//         );
//       },
//     );
//   }
// }

