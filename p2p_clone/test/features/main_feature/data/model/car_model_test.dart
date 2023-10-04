import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:p2p_clone/features/main_feature/domain/entities/car.dart';

import '../../../../json/reader.dart';

class MockCarModel extends Mock implements CarModel {}

void main() {
  late MockCarModel mockCarModel;
  CarModel tCarModel = CarModel.testDefault();

  setUp(() {
    mockCarModel = MockCarModel();
  });

  test('should be a subclass of Car entity', () async {
    // assert
    expect(mockCarModel, isA<Car>());
  });

  test('should return CarModel from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture('car.json'),
    );
    // act
    final result = CarModel.fromJson(jsonMap);
    // assert
    expect(result, tCarModel);
  });

  test('the json should be the same the toJson result', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture('car.json'),
    );
    // act
    final result = jsonDecode(tCarModel.toJson());
    // assert
    expect(jsonMap, result);
  });
}
