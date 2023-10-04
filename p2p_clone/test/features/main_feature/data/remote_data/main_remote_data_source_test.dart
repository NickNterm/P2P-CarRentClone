import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:p2p_clone/core/constants/urls.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:p2p_clone/features/main_feature/data/remote_data/main_remote_data_source.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late MainRemoteDataSourceImpl mainRemoteDataSourceImpl;
  setUpAll(() {
    mockHttpClient = MockHttpClient();
    mainRemoteDataSourceImpl = MainRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });
  List<CarModel> carList = [
    CarModel.testDefault(),
    CarModel.testDefault(),
  ];
  List<String> carListInput = [
    CarModel.testDefault().toJson(),
    CarModel.testDefault().toJson(),
  ];

  group("get cars", () {
    test('Should return the carList in the get cars', () async {
      // arrange
      when(() => mockHttpClient.get(Uri.parse(carsUrl))).thenAnswer(
          (_) async => http.Response(jsonEncode(carListInput), 200));
      // act
      final result = await mainRemoteDataSourceImpl.getCars();
      // assert
      expect(result, carList);
      verify(() => mockHttpClient.get(Uri.parse(carsUrl)));
    });
    test('should throw exception on error', () async {
      // arrange
      when(() => mockHttpClient.get(Uri.parse(carsUrl)))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      //act
      final call = mainRemoteDataSourceImpl.getCars;
      // assert
      expect(() => call(), throwsException);
      verify(() => mockHttpClient.get(Uri.parse(carsUrl)));
    });
  });

  group("add car", () {
    test("should return true if the api is successful", () async {
      // arrange
      when(
        () => mockHttpClient.post(
          Uri.parse(carsUrl),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(true), 200));
      // act
      final result =
          await mainRemoteDataSourceImpl.addCar(CarModel.testDefault());
      // assert
      expect(result, true);
      verify(
        () => mockHttpClient.post(
          Uri.parse(carsUrl),
          body: any(named: 'body'),
        ),
      );
    });
    test("should throw Exception if there is a problem with the call",
        () async {
      // arrange
      when(
        () => mockHttpClient.post(
          Uri.parse(carsUrl),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => http.Response('Something went wrong', 404));
      //act
      final call = mainRemoteDataSourceImpl.getCars;
      // assert
      expect(() => call(), throwsException);
    });
  });
}
