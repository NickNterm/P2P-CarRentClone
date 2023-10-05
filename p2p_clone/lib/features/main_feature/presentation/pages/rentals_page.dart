import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_clone/dependency_injection/main_injection.dart';
import 'package:p2p_clone/features/main_feature/domain/entities/car.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/cars/cars_bloc.dart';
import 'package:p2p_clone/features/main_feature/presentation/components/rental_card.dart';

class RentalsPage extends StatefulWidget {
  const RentalsPage({super.key});

  @override
  State<RentalsPage> createState() => _RentalsPageState();
}

class _RentalsPageState extends State<RentalsPage> {
  List<Car> cars = [];
  List<Car> filteredCars = [];

  void onValueChange(String value) {
    if (value.isEmpty) {
      filteredCars.clear();
      filteredCars.addAll(cars);
      setState(() {});
      return;
    }
    filteredCars.clear();
    filteredCars.addAll(
      cars
          .where(
            (car) => car.make.toLowerCase().contains(value.toLowerCase()),
          )
          .toList(),
    );
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    if (sl<CarsBloc>().state is CarsLoaded) {
      cars.clear();
      cars.addAll((sl<CarsBloc>().state as CarsLoaded).cars);
      filteredCars.clear();
      filteredCars.addAll(cars);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsBloc, CarsState>(
      builder: (context, state) {
        if (state is CarsLoaded) {
          cars.clear();
          cars.addAll(state.cars);
          return RefreshIndicator(
            onRefresh: () async {
              sl<CarsBloc>().add(GetCars());
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        onValueChange(value);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Search',
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var car = filteredCars[index];
                      return RentalCard(car: car);
                    },
                    itemCount: filteredCars.length,
                    shrinkWrap: true,
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
