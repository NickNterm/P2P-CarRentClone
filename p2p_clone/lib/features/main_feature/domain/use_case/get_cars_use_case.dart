import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import '../repository/main_repository.dart';

class GetCarsUseCase {
  final MainRepository repository;

  GetCarsUseCase({
    required this.repository,
  });

  Future<Either<Failure, List<CarModel>>> call() async {
    return await repository.getCars();
  }
}
