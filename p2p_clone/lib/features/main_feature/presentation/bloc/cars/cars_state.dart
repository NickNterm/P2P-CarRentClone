part of 'cars_bloc.dart';

@immutable
abstract class CarsState {}

class CarsInitial extends CarsState {}

class CarsLoading extends CarsState {}

class CarsLoaded extends CarsState {
  final List<Car> cars;

  CarsLoaded({required this.cars});
}

class CarsError extends CarsState {
  final String message;

  CarsError({required this.message});
}
