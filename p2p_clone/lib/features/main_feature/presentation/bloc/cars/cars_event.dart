part of 'cars_bloc.dart';

@immutable
abstract class CarsEvent {}

class GetCars extends CarsEvent {}

class AddCar extends CarsEvent {
  final Car car;

  AddCar({required this.car});
}
