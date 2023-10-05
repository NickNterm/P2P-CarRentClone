import 'package:p2p_clone/dependency_injection/main_injection.dart';
import 'package:p2p_clone/features/main_feature/data/local_data/auth_local_data_source.dart';
import 'package:p2p_clone/features/main_feature/data/remote_data/auth_remote_data_source.dart';
import 'package:p2p_clone/features/main_feature/data/repository/auth_repository_impl.dart';
import 'package:p2p_clone/features/main_feature/domain/repository/auth_repository.dart';
import 'package:p2p_clone/features/main_feature/domain/use_case/auth_with_creds_use_case.dart';
import 'package:p2p_clone/features/main_feature/domain/use_case/auth_with_fingerprint_use_case.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/auth/auth_bloc.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/cars/cars_bloc.dart';

Future<void> initAuth() async {
  // Bloc
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      authWithCredsUseCase: sl(),
      authWithFindgerprintUseCase: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authLocalDataSource: sl(),
      authRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreferences: sl(),
      localAuthentication: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => AuthWithCredsUseCase(
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AuthWithFindgerprintUseCase(
      authRepository: sl(),
    ),
  );
}
