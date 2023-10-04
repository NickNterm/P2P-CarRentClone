import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:p2p_clone/core/constants/cache_keys.dart';
import 'package:p2p_clone/features/main_feature/data/local_data/main_local_data_source.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late MainLocalDataSourceImpl mainLocalDataSourceImpl;
  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    mainLocalDataSourceImpl = MainLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  List<CarModel> carList = [
    CarModel.testDefault(),
    CarModel.testDefault(),
  ];

  List<String> carStringList = [
    CarModel.testDefault().toJson(),
    CarModel.testDefault().toJson(),
  ];

  group('getCars', () {
    test('should return List<CarModel> from SharedPreferences', () async {
      // arrange
      when(() => mockSharedPreferences.getStringList(any()))
          .thenReturn(carStringList);
      // act
      final result = await mainLocalDataSourceImpl.getCars();
      // assert
      expect(result, equals(carList));
      verify(() => mockSharedPreferences.getStringList(kCarsCacheKey));
    });
    test(
        'should throw error if there is an error with the data on the sharedPreferences',
        () async {
      // arrange
      when(() => mockSharedPreferences.getStringList(any()))
          .thenThrow(Exception());
      // act
      final call = mainLocalDataSourceImpl.getCars;
      // assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(() => mockSharedPreferences.getStringList(kCarsCacheKey));
    });
  });

  group('cacheCars', () {
    test('should call SharedPreferences to cache the data', () async {
      // arrange
      when(() => mockSharedPreferences.setStringList(any(), any()))
          .thenAnswer((_) async => true);
      // act
      final result = await mainLocalDataSourceImpl.cacheCars(carList);
      // assert
      expect(result, equals(true));
      verify(() => mockSharedPreferences.setStringList(
            kCarsCacheKey,
            carStringList,
          ));
    });
    test(
        'should throw error if there is an error with the data on the sharedPreferences',
        () async {
      // arrange
      when(() => mockSharedPreferences.setStringList(any(), any()))
          .thenThrow(Exception());
      // act
      final result = await mainLocalDataSourceImpl.cacheCars(carList);
      // assert
      expect(result, equals(false));
      verify(() => mockSharedPreferences.setStringList(
            kCarsCacheKey,
            carStringList,
          ));
    });
  });

  group('addCar', () {
    test('should call SharedPreferences to add the data', () async {
      // arrange
      when(() => mockSharedPreferences.getStringList(any()))
          .thenReturn(carStringList);
      when(() => mockSharedPreferences.setStringList(any(), any()))
          .thenAnswer((_) async => true);
      // act
      final result = await mainLocalDataSourceImpl.addCar(carList.first);
      // assert
      expect(result, equals(true));
      verify(() => mockSharedPreferences.setStringList(
            kCarsCacheKey,
            carStringList,
          ));
    });
    test(
        'should throw error if there is an error with the data on the sharedPreferences',
        () async {
      // arrange
      when(() => mockSharedPreferences.getStringList(any()))
          .thenReturn(carStringList);
      when(() => mockSharedPreferences.setStringList(any(), any()))
          .thenThrow(Exception());
      // act
      final result = await mainLocalDataSourceImpl.addCar(carList.first);
      // assert
      expect(result, equals(false));
      verify(() => mockSharedPreferences.setStringList(
            kCarsCacheKey,
            carStringList,
          ));
    });
  });
}
