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
  double carTranslateX = -100;
  double circleScale = 8;
  double textOpacity = 0;
  late StreamSubscription carListener;
  @override
  void initState() {
    super.initState();
    sl<CarsBloc>().add(GetCars());
    carListener = sl<CarsBloc>().stream.listen((state) {
      if (state is CarsLoaded) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        carTranslateX = MediaQuery.of(context).size.width / 2 - 50;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          circleScale = 1;
        });
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          textOpacity = 1;
        });
        Future.delayed(const Duration(seconds: 1), () {
          //  Navigator.pushReplacementNamed(context, '/home');
        });
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutSine,
            top: 0,
            bottom: 0,
            left: carTranslateX,
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
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutSine,
              opacity: textOpacity,
              child: Text(
                "P2P Car Rental Clone",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
