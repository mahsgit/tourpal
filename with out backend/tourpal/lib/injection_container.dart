// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tourpal/features/hotel/data/datasources/hotel_local_datasource.dart';
// import 'package:tourpal/features/hotel/data/repositories/hotel_repoimpl.dart';
// import 'package:tourpal/features/hotel/domain/repositories/hotel_repo.dart';
// import 'package:tourpal/features/hotel/domain/usecases/get_hotel.dart';
// import 'package:tourpal/features/hotel/domain/usecases/get_hotel_details.dart';
// import 'package:tourpal/features/hotel/presentation/bloc/hotel_bloc.dart';
// import 'package:tourpal/features/search/data/datasources/search_local_datasource.dart';
// import 'package:tourpal/features/search/data/repositories/search_repository.dart';
// import 'package:tourpal/features/search/domain/repositories/search_repository.dart';
// import 'package:tourpal/features/search/domain/usecases/search_places.dart';
// import 'package:tourpal/features/search/presentation/bloc/search_bloc.dart';

// import 'features/home/data/datasources/home_local_datasource.dart';
// import 'features/home/data/repositories/home_repository.dart';
// import 'features/home/domain/repositories/home_repository.dart';
// import 'features/home/domain/usecases/get_categories.dart';
// import 'features/home/domain/usecases/get_trending_place.dart';
// import 'features/home/domain/usecases/search_places.dart';
// import 'features/home/presentation/bloc/home_bloc.dart';
// import 'features/profile/data/datasources/profile_local_datasource.dart';
// import 'features/profile/data/repositories/profile_repo_impl.dart';
// import 'features/profile/domain/repositories/profile_repo.dart';
// import 'features/profile/domain/usecases/profile_usecase.dart';
// import 'features/profile/presentation/bloc/profile_bloc.dart';

// final sl = GetIt.instance;

// Future<void> init() async {
//   // Features - Home
//   // Bloc
//   sl.registerFactory(
//     () => HomeBloc(
//       getTrendingPlaces: sl(),
//       getCategories: sl(),
//       // searchPlaces: sl(),
//     ),
//   );
//    sl.registerFactory(
//     () => SearchBloc(
//       searchPlaces: sl(),
//     ),
//   );
//   sl.registerFactory(
//     () => HotelBloc(
//       getHotelDetails: sl(),
//       getHotels: sl(),
      
//     ),
//   );

//   // Use cases
//   sl.registerLazySingleton(() => GetTrendingPlaces(sl()));
//   sl.registerLazySingleton(() => GetCategories(sl()));
//   sl.registerLazySingleton(() => SearchPlaces(sl()));
//   sl.registerLazySingleton(() => GetHotelDetails (sl()));
//   sl.registerLazySingleton(() => GetHotels (sl()));


//   // Repository
//   sl.registerLazySingleton<HomeRepository>(
//     () => HomeRepositoryImpl(sl()),
//   );

//  sl.registerLazySingleton<SearchRepository>(
//     () => SearchRepositoryImpl(sl()),
//   );

// sl.registerLazySingleton<HotelRepository>(
//     () => HotelRepositoryImpl(localDataSource:sl()),
//   );
 

//   // Data sources
//   sl.registerLazySingleton<HomeLocalDataSource>(
//     () => HomeLocalDataSourceImpl(),
//   );
//    sl.registerLazySingleton<SearchLocalDataSource>(
//     () => SearchLocalDataSourceImpl(),
//   );
//    sl.registerLazySingleton<HotelLocalDataSource>(
//     () => HotelLocalDataSourceImpl(),
//   );

//   // Features - Profile
//   // Bloc
//   sl.registerFactory(
//     () => ProfileBloc(
//       getProfile: sl(),
//     ),
//   );

//   // Use cases
//   sl.registerLazySingleton(() => GetProfile(sl()));

//   // Repository
//   sl.registerLazySingleton<ProfileRepository>(
//     () => ProfileRepositoryImpl(sl()),
//   );

//   // Data sources
//   sl.registerLazySingleton<ProfileLocalDataSource>(
//     () => ProfileLocalDataSourceImpl(),
//   );

//   // External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
// }

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourpal/features/hotel/data/datasources/hotel_local_datasource.dart';
import 'package:tourpal/features/hotel/data/repositories/hotel_repoimpl.dart';
import 'package:tourpal/features/hotel/domain/repositories/hotel_repo.dart';
import 'package:tourpal/features/hotel/domain/usecases/get_hotel.dart';
import 'package:tourpal/features/hotel/domain/usecases/get_hotel_details.dart';
import 'package:tourpal/features/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:tourpal/features/search/data/datasources/search_local_datasource.dart';
import 'package:tourpal/features/search/data/repositories/search_repository.dart';
import 'package:tourpal/features/search/domain/repositories/search_repository.dart';
import 'package:tourpal/features/search/domain/usecases/search_places.dart';
import 'package:tourpal/features/search/presentation/bloc/search_bloc.dart';
import 'package:tourpal/features/trip_advisor/data/data_source/gemini_datasource.dart';
import 'package:tourpal/features/trip_advisor/data/data_source/local.dart';
import 'package:tourpal/features/trip_advisor/data/repository/trip_repo_impl.dart';
import 'package:tourpal/features/trip_advisor/domain/repository/trip_repo.dart';
import 'package:tourpal/features/trip_advisor/domain/usecase/gemini_usecase.dart';
import 'package:tourpal/features/trip_advisor/presentation/bloc/trip_bloc.dart';

import 'features/home/data/datasources/home_local_datasource.dart';
import 'features/home/data/repositories/home_repository.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_categories.dart';
import 'features/home/domain/usecases/get_trending_place.dart';
import 'features/home/domain/usecases/search_places.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/profile/data/datasources/profile_local_datasource.dart';
import 'features/profile/data/repositories/profile_repo_impl.dart';
import 'features/profile/domain/repositories/profile_repo.dart';
import 'features/profile/domain/usecases/profile_usecase.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Home
  // Bloc
  sl.registerFactory(
    () => HomeBloc(
      getTrendingPlaces: sl(),
      getCategories: sl(),
    ),
  );
  sl.registerFactory(
    () => SearchBloc(
      searchPlaces: sl(),
    ),
  );
  sl.registerFactory(
    () => HotelBloc(
      getHotelDetails: sl(),
      getHotels: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTrendingPlaces(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => SearchPlaces(sl()));
  sl.registerLazySingleton(() => GetHotelDetails(sl()));
  sl.registerLazySingleton(() => GetHotels(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<HotelRepository>(
    () => HotelRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<HotelLocalDataSource>(
    () => HotelLocalDataSourceImpl(),
  );

  // Features - Profile
  // Bloc
  sl.registerFactory(
    () => ProfileBloc(
      getProfile: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProfile(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );

  // Features - Trip Planner
  // Bloc
  sl.registerFactory(
    () => TripPlannerBloc(
      generateItineraryUseCase: sl(),
      repository: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GenerateItinerary(sl()));

  // Repository
  sl.registerLazySingleton<ItineraryRepository>(
    () => ItineraryRepositoryImpl(
      geminiApi: sl(),
      localStorage: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<GeminiApi>(
    () => GeminiApi(
      apiKey: const String.fromEnvironment('AIzaSyCJJDJnHk6kPtYs1pT6WKqLF37AS0nM9LE'),
    ),
  );
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(prefs: sharedPreferences),
  );

}

