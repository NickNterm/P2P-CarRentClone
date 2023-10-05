import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/core/network/network_info.dart';
import 'package:p2p_clone/features/main_feature/data/local_data/main_local_data_source.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:p2p_clone/features/main_feature/data/remote_data/main_remote_data_source.dart';
import 'package:p2p_clone/features/main_feature/data/repository/main_repository_impl.dart';

class MockMainLocalDataSource extends Mock implements MainLocalDataSource {}

class MockMainRemoteDataSource extends Mock implements MainRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MainRepositoryImpl repository;
  late MockMainLocalDataSource mockMainLocalDataSource;
  late MockMainRemoteDataSource mockMainRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockMainLocalDataSource = MockMainLocalDataSource();
    mockMainRemoteDataSource = MockMainRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MainRepositoryImpl(
      localDataSource: mockMainLocalDataSource,
      remoteDataSource: mockMainRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  List<CarModel> carList = [
    CarModel.testDefault(),
    CarModel.testDefault(),
  ];

  group('Get Cars', () {
    group('Having network connection', () {
      test('should return list with cars if everything is perfect', () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockMainRemoteDataSource.getCars()).thenAnswer(
          (_) async => carList,
        );
        when(() => mockMainLocalDataSource.cacheCars(carList)).thenAnswer(
          (_) async => true,
        );
        // act
        final result = await repository.getCars();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockMainRemoteDataSource.getCars());
        verify(() => mockMainLocalDataSource.cacheCars(carList));
        expect(result, equals(Right(carList)));
        verifyNoMoreInteractions(mockMainRemoteDataSource);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockMainLocalDataSource);
      });
      test(
          'shoule return error in case there is something wrong with the server request when remote data throws error',
          () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockMainRemoteDataSource.getCars()).thenThrow(
          Exception(),
        );
        when(() => mockMainLocalDataSource.cacheCars(carList)).thenAnswer(
          (_) async => true,
        );
        // act
        final result = await repository.getCars();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockMainRemoteDataSource.getCars());
        verifyNever(() => mockMainLocalDataSource.cacheCars(carList));
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    group('Having no network connection', () {
      test('should return list with cars if everything is perfect', () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockMainLocalDataSource.getCars()).thenAnswer(
          (_) async => carList,
        );
        // act
        final result = await repository.getCars();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockMainLocalDataSource.getCars());
        expect(result, equals(Right(carList)));
        verifyNoMoreInteractions(mockMainLocalDataSource);
        verifyZeroInteractions(mockMainRemoteDataSource);
        verifyNoMoreInteractions(mockNetworkInfo);
      });
      test(
          'should throw cache Error if there is a problem fetching data from the local source',
          () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockMainLocalDataSource.getCars()).thenThrow(
          Exception(),
        );
        // act
        final result = await repository.getCars();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockMainLocalDataSource.getCars());
        expect(result, equals(const Left(CacheFailure())));
        verifyNoMoreInteractions(mockMainLocalDataSource);
        verifyZeroInteractions(mockMainRemoteDataSource);
        verifyNoMoreInteractions(mockNetworkInfo);
      });
    });
  });

  group('Add Car', () {
    test('should return network error without connection in the network',
        () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.addCar(CarModel.testDefault());
      // assert
      verify(() => mockNetworkInfo.isConnected);
      expect(result, equals(const Left(NetworkFailure())));
      verifyZeroInteractions(mockMainRemoteDataSource);
      verifyZeroInteractions(mockMainLocalDataSource);
    });
    test('should return true if everything is perfect', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockMainRemoteDataSource.addCar(CarModel.testDefault()))
          .thenAnswer(
        (_) async => true,
      );
      // act
      final result = await repository.addCar(CarModel.testDefault());
      // assert
      verify(() => mockMainRemoteDataSource.addCar(CarModel.testDefault()));
      expect(result, equals(const Right(true)));
      verifyNoMoreInteractions(mockMainRemoteDataSource);
    });
    test(
        'should return error in case there is something wrong with the server request when remote data throws error',
        () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockMainRemoteDataSource.addCar(CarModel.testDefault()))
          .thenThrow(
        Exception(),
      );
      // act
      final result = await repository.addCar(CarModel.testDefault());
      // assert
      verify(() => mockMainRemoteDataSource.addCar(CarModel.testDefault()));
      expect(result, equals(const Left(ServerFailure())));
      verifyNoMoreInteractions(mockMainRemoteDataSource);
    });
  });
}
