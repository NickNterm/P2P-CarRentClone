import 'package:p2p_clone/dependency_injection/main_injection.dart';
import 'package:p2p_clone/features/main_feature/data/local_data/main_local_data_source.dart';
import 'package:p2p_clone/features/main_feature/data/remote_data/main_remote_data_source.dart';
import 'package:p2p_clone/features/main_feature/data/repository/main_repository_impl.dart';
import 'package:p2p_clone/features/main_feature/domain/repository/main_repository.dart';
import 'package:p2p_clone/features/main_feature/domain/use_case/get_cars_use_case.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/cars/cars_bloc.dart';

import '../features/main_feature/domain/use_case/add_car_use_case.dart';

// Init everything for the cars
Future<void> initCars() async {
  // Bloc
  sl.registerLazySingleton<CarsBloc>(
    () => CarsBloc(
      getCarsUseCase: sl(),
      addCarUseCase: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<MainRemoteDataSource>(
    () => MainRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<MainLocalDataSource>(
    () => MainLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => GetCarsUseCase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AddCarUseCase(
      repository: sl(),
    ),
  );
}
