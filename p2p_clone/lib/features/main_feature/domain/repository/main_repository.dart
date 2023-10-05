import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';

abstract class MainRepository {
  // Get all cars
  Future<Either<Failure, List<CarModel>>> getCars();

  // Add a new car to the list
  Future<Either<Failure, bool>> addCar(CarModel car);
}
