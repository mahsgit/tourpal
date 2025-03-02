// import 'package:flutter/material.dart';
// import 'package:tour/features/vr/panorama.dart';
// // import '../widgets/vr_place_card.dart';

// class VrExplorePage extends StatelessWidget {
//   const VrExplorePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('VR Exploration'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Trending places',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Discover our thoughtfully curated selection of unique and unforgettable destinations.',
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           color: Colors.grey[600],
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//             GridView.builder(
//               padding: const EdgeInsets.all(16),
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               itemCount: dummyPlaces.length,
//               itemBuilder: (context, index) {
//                 final place = dummyPlaces[index];
//                 return VrPlaceCard(
//                   title: place.title,
//                   imageUrl: place.imageUrl,
//                   rating: place.rating,
//                   price: place.price,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Panorama(
//                           panoImages: place.panoramaImages,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// final dummyPlaces = [
//   VrPlace(
//     title: 'African Union',
//     imageUrl: 'assets/images/african_union_1.jpg',
//     rating: 4.7,
//     price: 1200,
//     panoramaImages: ['assets/panorama/african_union_1.jpg'],
//   ),
//   VrPlace(
//     title: 'National Museum',
//     imageUrl: 'assets/images/national_museum_1.jpg',
//     rating: 4.5,
//     price: 1000,
//     panoramaImages: ['assets/panorama/national_museum_1.jpg'],
//   ),
//   // Add more places...
// ];

// class VrPlace {
//   final String title;
//   final String imageUrl;
//   final double rating;
//   final double price;
//   final List<String> panoramaImages;

//   VrPlace({
//     required this.title,
//     required this.imageUrl,
//     required this.rating,
//     required this.price,
//     required this.panoramaImages,
//   });
// }

