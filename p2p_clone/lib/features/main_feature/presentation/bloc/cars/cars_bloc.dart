import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:p2p_clone/features/main_feature/domain/entities/car.dart';
import 'package:p2p_clone/features/main_feature/domain/use_case/add_car_use_case.dart';
import 'package:p2p_clone/features/main_feature/domain/use_case/get_cars_use_case.dart';
part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  GetCarsUseCase getCarsUseCase;
  AddCarUseCase addCarUseCase;
  CarsBloc({
    required this.getCarsUseCase,
    required this.addCarUseCase,
  }) : super(CarsInitial()) {
    on<CarsEvent>((event, emit) async {
      if (event is GetCars) {
        emit(CarsLoading());
        final result = await getCarsUseCase();
        result.fold(
          (failure) => emit(CarsError(message: failure.message)),
          (cars) => emit(CarsLoaded(cars: cars)),
        );
      } else if (event is AddCar) {
        var carList = (state as CarsLoaded).cars;
        emit(CarsLoading());
        final result = await addCarUseCase(CarModel.fromEntity(event.car));
        result.fold(
          (failure) => emit(CarsError(message: failure.message)),
          (success) => emit(CarsLoaded(cars: [event.car, ...carList])),
        );
      }
    });
  }
}
