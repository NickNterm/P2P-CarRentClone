import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:p2p_clone/features/main_feature/domain/repository/main_repository.dart';
import 'package:p2p_clone/features/main_feature/domain/use_case/get_cars_use_case.dart';

class MockMainRepository extends Mock implements MainRepository {}

void main() {
  late MockMainRepository mockMainRepository;
  late GetCarsUseCase getCarsUseCase;
  setUp(() {
    mockMainRepository = MockMainRepository();
    getCarsUseCase = GetCarsUseCase(
      repository: mockMainRepository,
    );
  });

  List<CarModel> carList = [
    CarModel.testDefault(),
    CarModel.testDefault(),
  ];

  test('should return list of cars from repository', () async {
    // arrange
    when(() => mockMainRepository.getCars()).thenAnswer(
      (_) async => Right(carList),
    );
    // act
    final result = await getCarsUseCase();
    // assert
    expect(result, Right(carList));
    verify(() => mockMainRepository.getCars());
    verifyNoMoreInteractions(mockMainRepository);
  });
}
