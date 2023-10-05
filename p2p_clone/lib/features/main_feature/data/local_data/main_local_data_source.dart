import 'dart:convert';

import 'package:p2p_clone/core/constants/cache_keys.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MainLocalDataSource {
  Future<bool> addCar(CarModel car);
  Future<bool> cacheCars(List<CarModel> cars);
  Future<List<CarModel>> getCars();
}

class MainLocalDataSourceImpl extends MainLocalDataSource {
  SharedPreferences sharedPreferences;

  MainLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> addCar(CarModel car) {
    try {
      // Get the list of cars from cache
      List<String> cars = sharedPreferences.getStringList(kCarsCacheKey) ?? [];
      // Add the new car to the list
      sharedPreferences.setStringList(
        kCarsCacheKey,
        cars..add(car.toJson()),
      );
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> cacheCars(List<CarModel> cars) {
    try {
      // just push the list of the cars in the cache
      List<String> carStringList = cars.map((e) => e.toJson()).toList();
      sharedPreferences.setStringList(kCarsCacheKey, carStringList);
      return Future.value(true);
    } catch (_) {
      return Future.value(false);
    }
  }

  @override
  Future<List<CarModel>> getCars() async {
    try {
      // fetch the list of cars from cache
      List<String> carStringList =
          sharedPreferences.getStringList(kCarsCacheKey) ?? [];
      List<CarModel> cars =
          carStringList.map((e) => CarModel.fromJson(jsonDecode(e))).toList();
      return Future.value(cars);
    } catch (_) {
      throw Exception();
    }
  }
}
