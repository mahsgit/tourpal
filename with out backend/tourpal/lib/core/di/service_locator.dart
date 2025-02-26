// import 'package:get_it/get_it.dart';

// final sl = GetIt.instance;

// Future<void> initServiceLocator() async {
//   // AI Plan Feature
//   // Bloc
//   sl.registerFactory(
//     () => PlanBloc(generatePlan: sl()),
//   );

//   // Use cases
//   sl.registerLazySingleton(() => GeneratePlan(sl()));

//   // Repository
//   sl.registerLazySingleton<PlanRepository>(
//     () => PlanRepositoryImpl(
//       remoteDataSource: sl(),
//       localDataSource: sl(),
//       networkInfo: sl(),
//     ),
//   );

//   // Data sources
//   sl.registerLazySingleton<PlanRemoteDataSource>(
//     () => PlanRemoteDataSourceImpl(model: sl()),
//   );
//   sl.registerLazySingleton<PlanLocalDataSource>(
//     () => PlanLocalDataSourceImpl(sharedPreferences: sl()),
//   );

//   // External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
  
//   final model = GenerativeModel(
//     model: 'gemini-pro',
//     apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
//   );
//   sl.registerLazySingleton(() => model);
// }

