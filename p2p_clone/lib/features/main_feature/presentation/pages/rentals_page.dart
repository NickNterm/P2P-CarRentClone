import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_clone/dependency_injection/main_injection.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/cars/cars_bloc.dart';
import 'package:p2p_clone/features/main_feature/presentation/components/rental_card.dart';

class RentalsPage extends StatelessWidget {
  const RentalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsBloc, CarsState>(
      builder: (context, state) {
        if (state is CarsLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              sl<CarsBloc>().add(GetCars());
            },
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var car = state.cars[index];
                return RentalCard(car: car);
              },
              itemCount: state.cars.length,
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
