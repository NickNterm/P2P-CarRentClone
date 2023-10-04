import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';

import '../../../../core/constants/urls.dart';

abstract class MainRemoteDataSource {
  Future<List<CarModel>> getCars();
  Future<bool> addCar(CarModel car);
}

class MainRemoteDataSourceImpl extends MainRemoteDataSource {
  http.Client client;

  MainRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<bool> addCar(CarModel car) async {
    final response = await client.post(
      Uri.parse(carsUrl),
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<List<CarModel>> getCars() async {
    final response = await client.get(
      Uri.parse(carsUrl),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<CarModel> cars = [];
      try {
        for (var item in data) {
          cars.add(CarModel.fromJson(item));
        }
      } catch (_) {}
      return Future.value(cars);
    } else {
      throw Exception();
    }
  }
}
