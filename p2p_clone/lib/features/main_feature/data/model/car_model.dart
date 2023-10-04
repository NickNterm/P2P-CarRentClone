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
      return CarModel(
        id: int.parse(json['id']),
        make: json['make'],
        model: json['model'],
        price: (json['price'] as int).toDouble(),
        location: json['location'],
        availability: json['availability'],
      );
    } catch (e) {
      print(e);
      throw Exception('Error parsing json');
    }
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
