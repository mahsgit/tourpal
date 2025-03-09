// import 'package:flutter/material.dart';

// class VrExplorePage extends StatelessWidget {
//   const VrExplorePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('VR Exploration'),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
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
//           ),
//           SliverToBoxAdapter(
//             child: TrendingPlaces(
//               places: dummyPlaces,
//               onSeeAllPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const AllPlacesPage()),
//                 );
//               },
//               onImageTap: (place) {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Image.network(place.imageUrl),
//                         const SizedBox(height: 16),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Panorama(
//                                   panoImages: place.panoramaImages,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.panorama),
//                               SizedBox(width: 8),
//                               Text("View Panorama"),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TrendingPlaces extends StatelessWidget {
//   final List<VrPlace> places;
//   final VoidCallback onSeeAllPressed;
//   final Function(VrPlace) onImageTap;

//   const TrendingPlaces({
//     Key? key,
//     required this.places,
//     required this.onSeeAllPressed,
//     required this.onImageTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GridView.builder(
//           padding: const EdgeInsets.all(16),
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.75,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//           ),
//           itemCount: places.length,
//           itemBuilder: (context, index) {
//             final place = places[index];
//             return VrPlaceCard(
//               title: place.title,
//               imageUrl: place.imageUrl,
//               rating: place.rating,
//               price: place.price,
//               onTap: () => onImageTap(place),
//             );
//           },
//         ),
//         ElevatedButton(
//           onPressed: onSeeAllPressed,
//           child: const Text('See All'),
//         ),
//       ],
//     );
//   }
// }

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
//   VrPlace(
//     title: 'Unity Park',
//     imageUrl: 'assets/images/unity_park_1.jpg',
//     rating: 4.8,
//     price: 1500,
//     panoramaImages: ['assets/panorama/unity_park_1.jpg'],
//   ),
//   VrPlace(
//     title: 'Entoto Park',
//     imageUrl: 'assets/images/entoto_park_1.jpg',
//     rating: 4.6,
//     price: 800,
//     panoramaImages: ['assets/panorama/entoto_park_1.jpg'],
//   ),
// ];

