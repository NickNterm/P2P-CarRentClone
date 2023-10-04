import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:p2p_clone/features/main_feature/domain/repository/main_repository.dart';
import 'package:p2p_clone/features/main_feature/domain/use_case/add_car_use_case.dart';

class MockMainRepository extends Mock implements MainRepository {}

void main() {
  late MockMainRepository mockMainRepository;
  late AddCarUseCase addCarUseCase;
  setUp(() {
    mockMainRepository = MockMainRepository();
    addCarUseCase = AddCarUseCase(
      repository: mockMainRepository,
    );
  });

  test('should add a car in the list and return bool', () async {
    // arrange
    when(() => mockMainRepository.addCar(CarModel.testDefault())).thenAnswer(
      (_) async => const Right(true),
    );
    // act
    final result = await addCarUseCase(CarModel.testDefault());
    // assert
    expect(result, const Right(true));
    verify(() => mockMainRepository.addCar(CarModel.testDefault()));
    verifyNoMoreInteractions(mockMainRepository);
  });
}
