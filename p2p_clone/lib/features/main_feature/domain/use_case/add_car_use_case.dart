import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:p2p_clone/features/main_feature/domain/repository/main_repository.dart';

class AddCarUseCase {
  final MainRepository repository;

  AddCarUseCase({
    required this.repository,
  });

  Future<Either<Failure, bool>> call(CarModel car) async {
    return await repository.addCar(car);
  }
}
