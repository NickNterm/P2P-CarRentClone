import 'dart:async';

import 'package:flutter/material.dart';
import 'package:p2p_clone/dependency_injection/main_injection.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/cars/cars_bloc.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double carTranslateX = -300;
  double circleScale = 8;
  late StreamSubscription carListener;
  @override
  void initState() {
    // This is a bad but simple way to do an animation and then fetch the data
    super.initState();
    carListener = sl<CarsBloc>().stream.listen((state) {
      if (state is CarsLoaded) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      setState(() {
        carTranslateX = -50;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          circleScale = 1;
        });
      });
      Future.delayed(const Duration(seconds: 1), () {
        sl<CarsBloc>().add(GetCars());
      });
    });
  }

  @override
  void dispose() {
    carListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedScale(
              curve: Curves.easeOutSine,
              duration: const Duration(milliseconds: 500),
              scale: circleScale,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade600,
                ),
              ),
            ),
          ),
          AnimatedPositionedDirectional(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutSine,
            top: 0,
            bottom: 0,
            start: carTranslateX + (MediaQuery.of(context).size.width / 2),
            child: Image.asset(
              'assets/icons/Vectorcar.png',
              height: 100,
              width: 100,
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Text(
              "P2P Car Rental Clone",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
