import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final int id;
  final String make;
  final String model;
  final double price;
  final String location;
  final bool availability;

  const Car({
    required this.id,
    required this.make,
    required this.model,
    required this.price,
    required this.location,
    required this.availability,
  });

  @override
  List<Object?> get props => [
        id,
        make,
        model,
        price,
        location,
        availability,
      ];
}
