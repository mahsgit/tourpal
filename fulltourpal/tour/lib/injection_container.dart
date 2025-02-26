// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tour/features/profile/data/datasources/profile_local_datasource.dart';
// import 'package:tour/features/profile/data/datasources/profile_remote_datasource.dart';
// import 'package:tour/features/profile/data/repositories/profile_repository_impl.dart';
// import 'package:tour/features/profile/domain/repositories/profile_repository.dart';
// import 'package:tour/features/profile/domain/usecases/delete_profile.dart';
// import 'package:tour/features/profile/domain/usecases/get_current_profile.dart';
// import 'package:tour/features/profile/domain/usecases/update_profile.dart';
// import 'core/network/network_info.dart';
// import 'features/auth/auth/data/datasources/auth_local_datasource.dart';
// import 'features/auth/auth/data/datasources/auth_remote_datasource.dart';
// import 'features/auth/auth/data/repositories/auth_repository_impl.dart';
// import 'features/auth/auth/domain/repositories/auth_repository.dart';
// import 'features/auth/auth/domain/usecases/forgot_password.dart';
// import 'features/auth/auth/domain/usecases/google_login.dart';
// import 'features/auth/auth/domain/usecases/login.dart';
// import 'features/auth/auth/domain/usecases/logout.dart';
// import 'features/auth/auth/domain/usecases/refresh_token.dart';
// import 'features/auth/auth/domain/usecases/register.dart';
// import 'features/auth/auth/domain/usecases/reset_password.dart';
// import 'features/auth/auth/domain/usecases/validate_email.dart';
// import 'features/auth/auth/presentation/bloc/auth_bloc.dart';
// import 'features/profile/presentation/bloc/profile_bloc.dart';

// final sl = GetIt.instance;

// Future<void> init() async {
//   // Features - Auth
//   // Bloc
//   sl.registerFactory(
//     () => AuthBloc(
//       loginUseCase: sl(),
//       registerUseCase: sl(),
//       googleLoginUseCase: sl(),
//       logoutUseCase: sl(),
//       refreshTokenUseCase: sl(),
//       forgotPasswordUseCase: sl(),
//       resetPasswordUseCase: sl(),
//       validateEmailUseCase: sl(),
//     ),
//   );

//   // Use cases
//   sl.registerLazySingleton(() => LoginUseCase(sl()));
//   sl.registerLazySingleton(() => RegisterUseCase(sl()));
//   sl.registerLazySingleton(() => GoogleLoginUseCase(sl()));
//   sl.registerLazySingleton(() => LogoutUseCase(sl()));
//   sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
//   sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
//   sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
//   sl.registerLazySingleton(() => ValidateEmailUseCase(sl()));

//   // Repository
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(
//       remoteDataSource: sl(),
//       localDataSource: sl(),
//       networkInfo: sl(),
//     ),
//   );

//   // Data sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(client: sl()),
//   );
//   sl.registerLazySingleton<AuthLocalDataSource>(
//     () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
//   );

//   // Core
//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//   // External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//     sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());



// Future<void> _initProfile() async {
//   // Bloc
//   sl.registerFactory(
//     () => ProfileBloc(
//       getCurrentProfile: sl(),
//       updateProfile: sl(),
//       deleteProfile: sl(),
//     ),
//   );

//   // Use cases
//   sl.registerLazySingleton(() => GetCurrentProfile(sl()));
//   sl.registerLazySingleton(() => UpdateProfile(sl()));
//   sl.registerLazySingleton(() => DeleteProfile(sl()));

//   // Repository
//   sl.registerLazySingleton<ProfileRepository>(
//     () => ProfileRepositoryImpl(
//       remoteDataSource: sl(),
//       localDataSource: sl(),
//       networkInfo: sl(),
//     ),
//   );

//   // Data sources
//   sl.registerLazySingleton<ProfileRemoteDataSource>(
//     () => ProfileRemoteDataSourceImpl(client: sl()),
//   );
//   sl.registerLazySingleton<ProfileLocalDataSource>(
//     () => ProfileLocalDataSourceImpl(sharedPreferences: sl()),
//   );


 






// }

// }

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:tour/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:tour/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:tour/features/profile/domain/repositories/profile_repository.dart';
import 'package:tour/features/profile/domain/usecases/delete_profile.dart';
import 'package:tour/features/profile/domain/usecases/get_current_profile.dart';
import 'package:tour/features/profile/domain/usecases/update_profile.dart';
import 'core/network/network_info.dart';
import 'features/auth/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/auth/domain/repositories/auth_repository.dart';
import 'features/auth/auth/domain/usecases/forgot_password.dart';
import 'features/auth/auth/domain/usecases/google_login.dart';
import 'features/auth/auth/domain/usecases/login.dart';
import 'features/auth/auth/domain/usecases/logout.dart';
import 'features/auth/auth/domain/usecases/refresh_token.dart';
import 'features/auth/auth/domain/usecases/register.dart';
import 'features/auth/auth/domain/usecases/reset_password.dart';
import 'features/auth/auth/domain/usecases/validate_email.dart';
import 'features/auth/auth/presentation/bloc/auth_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Auth
  await _initAuth();

  // Profile
  await _initProfile();

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

