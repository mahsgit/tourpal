import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tour/features/ai_planner/presentation/bloc/ai_planner_bloc.dart';
// import 'package:tour/features/ai_planner/presentation/pages/ai_planner_page.dart';

import 'package:tour/features/auth/auth/presentation/bloc/auth_bloc.dart';
import 'package:tour/features/auth/auth/presentation/pages/login_page.dart';
import 'package:tour/features/auth/auth/presentation/pages/register_page.dart';
import 'package:tour/features/home/home.dart';
import 'package:tour/features/trip_advisor/presentation/bloc/trip_bloc.dart';
import 'package:tour/features/trip_advisor/presentation/page/trip_page.dart';
// import 'package:tour/features/trip_advisor/presentation/bloc/trip_bloc.dart';
// import 'package:tour/features/trip_advisor/presentation/page/trip_page.dart';
import 'injection_container.dart' as di;

// Features

import 'features/profile/presentation/pages/profile_page.dart';
import 'features/profile/presentation/pages/edit_profile_page.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/profile/domain/entities/user_profile_entity.dart';
import 'features/business/presentation/pages/business_list_page.dart';
import 'features/business/presentation/pages/business_details_page.dart';
import 'features/business/presentation/bloc/business_bloc.dart';
import 'features/business/presentation/pages/booking_page.dart';
import 'features/business/domain/entities/business_entity.dart';

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
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => di.sl<ProfileBloc>(),
        ),
        BlocProvider<TripPlannerBloc>(
          create: (context) => di.sl<TripPlannerBloc>(),
        ),
        BlocProvider<BusinessBloc>(
          create: (context) => di.sl<BusinessBloc>(),
          lazy: false,  // Added to ensure immediate creation
        ),
      ],
      child: MaterialApp(
        title: 'TourPal',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        initialRoute: '/login',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
            case '/businesses':
              return MaterialPageRoute(
                builder: (_) => const BusinessListPage(),
              );
            case '/login':
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
              );
            case '/register':
              return MaterialPageRoute(
                builder: (_) => const RegisterPage(),
              );
           
            case '/home':
              return MaterialPageRoute(
                builder: (_) => const HomePage(),
              );
               case '/aiplanner':
              return MaterialPageRoute(
                builder: (_) => const TripPlannerPage(),
              );
            case '/profile/edit':
              final profile = settings.arguments as UserProfileEntity;
              return MaterialPageRoute(
                builder: (_) => EditProfilePage(profile: profile),
              );
            case '/business/details':
              final businessId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => BusinessDetailsPage(businessId: businessId),
              );
            case '/business/booking':
              final business = settings.arguments as BusinessEntity;
              return MaterialPageRoute(
                builder: (_) => BookingPage(business: business),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
              );
          }
        },
      ),
    );
  }
}

