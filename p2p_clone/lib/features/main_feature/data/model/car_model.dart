import 'package:p2p_clone/features/main_feature/domain/entities/car.dart';

class CarModel extends Car {
  const CarModel({
    required super.id,
    required super.make,
    required super.model,
    required super.price,
    required super.location,
    required super.availability,
  });

  factory CarModel.testDefault() {
    return const CarModel(
      id: 1,
      make: 'Polestar',
      model: 'Countach',
      price: 220,
      location: 'Syracuse',
      availability: true,
    );
  }

  factory CarModel.fromJson(Map<String, dynamic> json) {
    try {
      var price = json['price'];
      if (price is String) {
        price = double.parse(price);
      } else if (price is int) {
        price = price.toDouble();
      }
      return CarModel(
        id: int.parse(json['id']),
        make: json['make'],
        model: json['model'],
        price: price,
        location: json['location'],
        availability: json['availability'],
      );
    } catch (e) {
      throw Exception('Error parsing json');
    }
  }

  factory CarModel.fromEntity(Car car) {
    return CarModel(
      id: car.id,
      make: car.make,
      model: car.model,
      price: car.price,
      location: car.location,
      availability: car.availability,
    );
  }

  String toJson() {
    return '''
      {
        "id": "${super.id}",
        "make": "${super.make}",
        "model": "${super.model}",
        "price": ${super.price},
        "location": "${super.location}",
        "availability": ${super.availability}
      }
    ''';
  }
}
