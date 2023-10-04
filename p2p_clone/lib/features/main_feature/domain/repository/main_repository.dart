import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/domain/entities/car.dart';

abstract class MainRepository {
  Future<Either<Failure, List<Car>>> getCars();
  Future<Either<Failure, bool>> addCar(Car car);
}
