import 'package:p2p_clone/features/main_feature/domain/entities/car.dart';

abstract class MainLocalDataSource {
  Future<List<Car>> getCars();
  Future<bool> cacheCars(List<Car> cars);
  Future<bool> addCar(Car car);
}
