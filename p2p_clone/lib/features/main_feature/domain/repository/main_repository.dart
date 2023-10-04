import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';

abstract class MainRepository {
  Future<Either<Failure, List<CarModel>>> getCars();
  Future<Either<Failure, bool>> addCar(CarModel car);
}
