import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/core/network/network_info.dart';
import 'package:p2p_clone/features/main_feature/data/local_data/main_local_data_source.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:p2p_clone/features/main_feature/data/remote_data/main_remote_data_source.dart';
import 'package:p2p_clone/features/main_feature/domain/repository/main_repository.dart';

class MainRepositoryImpl extends MainRepository {
  MainLocalDataSource localDataSource;
  MainRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  MainRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> addCar(CarModel car) async {
    if (await networkInfo.isConnected) {
      try {
        // if there is connect add the car to the api
        final flag = await remoteDataSource.addCar(car);
        // again adding to cache is not that important
        try {
          localDataSource.addCar(car);
        } catch (_) {}
        return Right(flag);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      // if there is no connection, return a network failure
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<CarModel>>> getCars() async {
    if (await networkInfo.isConnected) {
      // if it is connected to network get the cars from the api
      try {
        final remoteCars = await remoteDataSource.getCars();
        // if there is an error in caching, we don't care too much
        try {
          // cache the data locally
          localDataSource.cacheCars(remoteCars);
        } catch (_) {}
        return Right(remoteCars);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      // if there is no network connection, get the cars from the local storage
      try {
        final localCars = await localDataSource.getCars();
        return Right(localCars);
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }
}
