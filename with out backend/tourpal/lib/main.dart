

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourpal/features/home/presentation/places/pages/all_place_page.dart';
import 'package:tourpal/features/home/presentation/places/pages/place_detail.dart';
import 'package:tourpal/features/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:tourpal/features/hotel/presentation/pages/hotel_detail_page.dart';
import 'package:tourpal/features/hotel/presentation/pages/hotel_page.dart';
import 'package:tourpal/features/hotel/presentation/pages/room_services.dart';
import 'package:tourpal/features/payment/payment_page.dart';
import 'package:tourpal/features/payment/payment_result.dart';
import 'package:tourpal/features/search/presentation/bloc/search_bloc.dart';
import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_bloc.dart';
import 'package:tourpal/features/trip_advisor/presentation/page/trip_page.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<HotelBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<TripPlannerBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'TourPal',
        theme: ThemeData(
          primaryColor: const Color(0xFFFF5A5F),
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF5A5F),
            primary: const Color(0xFFFF5A5F),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5A5F),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFFF5A5F)),
            ),
          ),
          chipTheme: ChipThemeData(
            selectedColor: const Color(0xFFFF5A5F),
            labelStyle: const TextStyle(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/hotels': (context) => const HotelsPage(),
          '/hotel-details': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return HotelDetailsPage(hotelId: args['hotelId']);
          },
          '/room-services': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return RoomServicesPage(hotelId: args['hotelId']);
          },
          '/all-places': (context) => const AllPlacesPage(),

          // '/payment': (context) => const PaymentPage(),

          '/payment-result': (context) => const PaymentResultPage(),
          // '/chat': (context) => const Chat(),
          '/place-details': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return PlaceDetailPage(place: args['place']);
          },
          '/trip': (context) => TripPlannerPage(),
        },
      ),
    );
  }
}

