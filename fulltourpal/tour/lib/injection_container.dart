

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour/features/ai_planner/data/datasources/ai_planner_local_data_source.dart';
import 'package:tour/features/ai_planner/data/datasources/ai_planner_remote_data_source.dart';
import 'package:tour/features/ai_planner/data/repositories/ai_planner_repository_impl.dart';
import 'package:tour/features/ai_planner/domain/repositories/ai_planner_repository.dart';
import 'package:tour/features/ai_planner/domain/usecases/generate_itinerary.dart';
import 'package:tour/features/ai_planner/presentation/bloc/ai_planner_bloc.dart';
import 'package:tour/features/auth/auth/data/datasources/auth_local_datasource.dart';
import 'package:tour/features/auth/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tour/features/auth/auth/data/repositories/auth_repository_impl.dart';
import 'package:tour/features/auth/auth/domain/repositories/auth_repository.dart';
import 'package:tour/features/auth/auth/domain/usecases/forgot_password.dart';
import 'package:tour/features/auth/auth/domain/usecases/google_login.dart';
import 'package:tour/features/auth/auth/domain/usecases/login.dart';
import 'package:tour/features/auth/auth/domain/usecases/logout.dart';
import 'package:tour/features/auth/auth/domain/usecases/refresh_token.dart';
import 'package:tour/features/auth/auth/domain/usecases/register.dart';
import 'package:tour/features/auth/auth/domain/usecases/reset_password.dart';
import 'package:tour/features/auth/auth/domain/usecases/validate_email.dart';
import 'package:tour/features/auth/auth/presentation/bloc/auth_bloc.dart';
import 'package:tour/features/rooms/data/datasources/room_local_data_source.dart';
import 'package:tour/features/rooms/data/datasources/room_remote_data_source.dart';
import 'package:tour/features/rooms/data/repositories/room_repository_impl.dart';
import 'package:tour/features/rooms/domain/repositories/room_repository.dart';
import 'package:tour/features/rooms/domain/usecases/get_room_type_details.dart';
import 'package:tour/features/rooms/domain/usecases/get_room_types.dart';
import 'package:tour/features/rooms/domain/usecases/search_room_types.dart';
import 'package:tour/features/rooms/presentation/bloc/room_bloc.dart';
// import 'package:tour/features/trip_advisor/data/data_source/gemini_datasource.dart';
// import 'package:tour/features/trip_advisor/data/data_source/local.dart';
// import 'package:tour/features/trip_advisor/data/repository/trip_repo_impl.dart';
// import 'package:tour/features/trip_advisor/domain/repository/trip_repo.dart';
// import 'package:tour/features/trip_advisor/domain/usecase/gemini_usecase.dart';
// import 'package:tour/features/trip_advisor/presentation/bloc/trip_bloc.dart';

// Core
import 'core/network/network_info.dart';



// Profile Feature
import 'features/profile/data/datasources/profile_local_datasource.dart';
import 'features/profile/data/datasources/profile_remote_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/delete_profile.dart';
import 'features/profile/domain/usecases/get_current_profile.dart';
import 'features/profile/domain/usecases/update_profile.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

// Business Feature
import 'features/business/data/datasources/business_local_datasource.dart';
import 'features/business/data/datasources/business_remote_datasource.dart';
import 'features/business/data/repositories/business_repository_impl.dart';
import 'features/business/domain/repositories/business_repository.dart';
import 'features/business/domain/usecases/get_businesses.dart';
import 'features/business/domain/usecases/get_business_details.dart';
import 'features/business/presentation/bloc/business_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Auth
  await _initAuth();

  // Profile
  await _initProfile();

  // Business
  await _initBusiness();

  // AI Planner
  await _initAIPlanner();

  // Room
  await _initRoom();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}

Future<void> _initAuth() async {
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      googleLoginUseCase: sl(),
      logoutUseCase: sl(),
      refreshTokenUseCase: sl(),
      forgotPasswordUseCase: sl(),
      resetPasswordUseCase: sl(),
      validateEmailUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GoogleLoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ValidateEmailUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
}

Future<void> _initProfile() async {
  // Bloc
  sl.registerFactory(
    () => ProfileBloc(
      getCurrentProfile: sl(),
      updateProfile: sl(),
      deleteProfile: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCurrentProfile(sl()));
  sl.registerLazySingleton(() => UpdateProfile(sl()));
  sl.registerLazySingleton(() => DeleteProfile(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(sharedPreferences: sl()),
  );
}

Future<void> _initBusiness() async {
  // Bloc
  sl.registerFactory<BusinessBloc>(  // Changed to explicit type
    () => BusinessBloc(
      getBusinesses: sl<GetBusinesses>(),  // Added explicit types
      getBusinessDetails: sl<GetBusinessDetails>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<GetBusinesses>(() => GetBusinesses(sl()));  // Added explicit types
  sl.registerLazySingleton<GetBusinessDetails>(() => GetBusinessDetails(sl()));

  // Repository
  sl.registerLazySingleton<BusinessRepository>(
    () => BusinessRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<BusinessRemoteDataSource>(
    () => BusinessRemoteDataSourceImpl(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<BusinessLocalDataSource>(
    () => BusinessLocalDataSourceImpl(sharedPreferences: sl()),
  );
}



 Future <void> _initAIPlanner() async {
  // Bloc
  sl.registerFactory(
    () => AIPlannerBloc(
      generateItinerary: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GenerateItinerary(sl()));

  // Repository
  sl.registerLazySingleton<AIPlannerRepository>(
    () => AIPlannerRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AIPlannerRemoteDataSource>(
    () => AIPlannerRemoteDataSourceImpl(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );
  
  sl.registerLazySingleton<AIPlannerLocalDataSource>(
    () => AIPlannerLocalDataSourceImpl(sharedPreferences: sl()),
  );
 }
 

//  Future <void> _initAIPlanner() async {
//   // Bloc
//   sl.registerFactory(
//     () => TripPlannerBloc(
//       generateItineraryUseCase: sl(),
//       repository: sl(),
//     ),
//   );


//   // Use cases
//   sl.registerLazySingleton(() => GenerateItinerary(sl()));

//   // Repository
//   sl.registerLazySingleton<ItineraryRepository>(
//     () => ItineraryRepositoryImpl(
//       geminiApi: sl(),
//       localStorage: sl(),
//     ),
//   );

//   // Data sources
//   sl.registerLazySingleton<GeminiApi>(
//     () => GeminiApi(
//       apiKey: const String.fromEnvironment('AIzaSyCJJDJnHk6kPtYs1pT6WKqLF37AS0nM9LE'),
//     ),
//   );

//   sl.registerLazySingleton<LocalStorage>(
//     () => LocalStorageImpl(prefs: sl()),
//   );
//  }



Future<void> _initRoom() async {
  // Bloc
  sl.registerFactory<RoomBloc>(
    () => RoomBloc(
      getRoomTypes: sl<GetRoomTypes>(),
      searchRoomTypes: sl<SearchRoomTypes>(),
      getRoomTypeDetails: sl<GetRoomTypeDetails>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<GetRoomTypes>(() => GetRoomTypes(sl<RoomRepository>()));
  sl.registerLazySingleton<SearchRoomTypes>(() => SearchRoomTypes(sl<RoomRepository>()));
  sl.registerLazySingleton<GetRoomTypeDetails>(() => GetRoomTypeDetails(sl<RoomRepository>()));

  // Repository
  sl.registerLazySingleton<RoomRepository>(
    () => RoomRepositoryImpl(
      remoteDataSource: sl<RoomRemoteDataSource>(),
      localDataSource: sl<RoomLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RoomRemoteDataSource>(
    () => RoomRemoteDataSourceImpl(
       client: sl(),
      authLocalDataSource: sl(),
    ),
  );


  
  
  sl.registerLazySingleton<RoomLocalDataSource>(
    () => RoomLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()),
  );
}