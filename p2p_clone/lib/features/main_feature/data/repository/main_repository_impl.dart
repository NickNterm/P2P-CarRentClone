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
    // logic is shown in tests
    if (await networkInfo.isConnected) {
      try {
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
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<CarModel>>> getCars() async {
    // logic is shown in tests
    if (await networkInfo.isConnected) {
      try {
        final remoteCars = await remoteDataSource.getCars();
        // if there is an error in caching, we don't care too much
        try {
          localDataSource.cacheCars(remoteCars);
        } catch (_) {}
        return Right(remoteCars);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localCars = await localDataSource.getCars();
        return Right(localCars);
      } catch (e) {
        return const Left(CacheFailure());
      }
    }
  }
}
