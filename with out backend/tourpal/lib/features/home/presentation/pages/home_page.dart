import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourpal/features/home/presentation/places/pages/all_place_page.dart';
import 'package:tourpal/features/home/presentation/widgets/recommeded_place.dart';
import 'package:tourpal/features/home/presentation/widgets/treding_places.dart';
import 'package:tourpal/features/hotel/presentation/widgets/servicesection.dart';
import 'package:tourpal/panorama.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_header.dart';
import '../widgets/categories_list.dart';
import '../widgets/bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              context.read<HomeBloc>().add(LoadHomeContent());
              return const Center(child: CircularProgressIndicator());
            }
            
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (state is HomeLoaded) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: HomeHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: ServicesSection(),
                  ),
                  SliverToBoxAdapter(
                    child: TrendingPlaces(
                      places: state.trendingPlaces,
                      onSeeAllPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AllPlacesPage()),
                        );
                      },
                      onImageTap: (place) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(place.imageUrl),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Panorama(
                                          panoImages: [
                                            'lib/asset/panorama2.webp',
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.panorama),
                                      SizedBox(width: 8),
                                      Text("View Panorama"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CategoriesList(categories: state.categories),
                  ),
                  SliverToBoxAdapter(
                    child: RecommendedPlaces(
                      places: state.trendingPlaces,
                      onSeeAllPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AllPlacesPage()),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            
            if (state is HomeError) {
              return Center(
                child: Text(state.message),
              );
            }
            
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/payment');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/trip');
          }
        },
      ),
    );
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tourpal/features/home/presentation/places/pages/all_place_page.dart';
// import 'package:tourpal/features/home/presentation/widgets/recommeded_place.dart';
// import 'package:tourpal/features/home/presentation/widgets/treding_places.dart';
// import 'package:tourpal/features/hotel/presentation/widgets/servicesection.dart';
// import 'package:tourpal/panorama.dart';
// import '../../../advertisement/presentation/add_bloc/add_bloc.dart';
// import '../../../advertisement/presentation/widget/add_widget.dart';
// import '../bloc/home_bloc.dart';
// import '../widgets/home_header.dart';
// import '../widgets/categories_list.dart';
// import '../widgets/bottom_navigation.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool _showingAd = false;
//   late Timer _adTimer;

//   @override
//   void initState() {
//     super.initState();
//     _startAdTimer();
//   }

//   @override
//   void dispose() {
//     _adTimer.cancel();
//     super.dispose();
//   }

//   void _startAdTimer() {
//   }
//   //   _adTimer = Timer.periodic(Duration(minutes: 1), (timer) {
//   //     context.read<AdvertisementBloc>().add(FetchAdvertisement());
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AdvertisementBloc, AdvertisementState>(
//       listener: (context, state) {
//         if (state is AdvertisementLoaded) {
//           setState(() {
//             _showingAd = true;
//           });
//         }
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child :
//           // child: _showingAd
//           //     ? BlocBuilder<AdvertisementBloc, AdvertisementState>(
//           //         builder: (context, state) {
//           //           if (state is AdvertisementLoaded) {
//           //             return AdvertisementVideoPlayer(
//           //               advertisement: state.advertisement,
//           //               onComplete: () {
//           //                 setState(() {
//           //                   _showingAd = false;
//           //                 });
//           //               },
//           //             );
//           //           }
//           //           return Center(child: CircularProgressIndicator());
//           //         },
//           //       )
//           //     :
//                BlocBuilder<HomeBloc, HomeState>(
//                   builder: (context, state) {
//                     if (state is HomeInitial) {
//                       context.read<HomeBloc>().add(LoadHomeContent());
//                       return const Center(child: CircularProgressIndicator());
//                     }
                    
//                     if (state is HomeLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
                    
//                     if (state is HomeLoaded) {
//                       return CustomScrollView(
//                         slivers: [
//                           const SliverToBoxAdapter(
//                             child: HomeHeader(),
//                           ),
//                           SliverToBoxAdapter(
//                             child: ServicesSection(),
//                           ),
//                           SliverToBoxAdapter(
//                             child: TrendingPlaces(
//                               places: state.trendingPlaces,
//                               onSeeAllPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => const AllPlacesPage()),
//                                 );
//                               },
//                               onImageTap: (place) {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     content: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Image.network(place.imageUrl),
                                        

// ElevatedButton(
//                                           onPressed: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//           builder: (context) => const Panorama(
//             panoImages: [
//               'lib/asset/panorama2.webp',
//             ],
//           ),
//                                               ),
//                                             );
//                                           },
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Icon(Icons.panorama),
//                                               SizedBox(width: 8),
//                                               Text("View Panorama"),
//                                             ],
//                                           ),
//                                         ),

//                                         // ElevatedButton(
//                                         //   onPressed: () {
//                                         //     Navigator.push(
//                                         //       context,
//                                         //       MaterialPageRoute(
//                                         //         builder: (context) => const Panorama(
//                                         //           panoImages: [
//                                         //             'lib/asset/panorama2.webp',
//                                         //           ],
//                                         //         ),
//                                         //       ),
//                                         //     );
//                                         //   },
//                                         //   child: Row(
//                                         //     mainAxisSize: MainAxisSize.min,
//                                         //     children: [
//                                         //       Icon(Icons.panorama),
//                                         //       SizedBox(width: 8),
//                                         //       Text("View Panorama"),
//                                         //     ],
//                                         //   ),
//                                         // ),










//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           SliverToBoxAdapter(
//                             child: CategoriesList(categories: state.categories),
//                           ),
//                           SliverToBoxAdapter(
//                             child: RecommendedPlaces(
//                               places: state.trendingPlaces,
//                               onSeeAllPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => const AllPlacesPage()),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     }
                    
//                     if (state is HomeError) {
//                       return Center(
//                         child: Text(state.message),
//                       );
//                     }
                    
//                     return const SizedBox.shrink();
//                   },
//                 ),
//         ),
//         bottomNavigationBar: BottomNavigation(
//           currentIndex: 1,
//           onTap: (index) {
//             if (index == 0) {
//               Navigator.pushNamed(context, '/payment');
//             } else if (index == 2) {
//               Navigator.pushNamed(context, '/chat');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

