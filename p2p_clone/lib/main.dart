import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_clone/dependency_injection/main_injection.dart';
import 'package:p2p_clone/features/loading_feature/presentation/loading_page.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/cars/cars_bloc.dart';
import 'package:p2p_clone/features/main_feature/presentation/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CarsBloc>(
          create: (context) => sl<CarsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade600,
          ),
          useMaterial3: true,
        ),
        home: const LoadingPage(),
        routes: {
          '/loading': (context) => const LoadingPage(),
          '/home': (context) => const MainPage(),
        },
      ),
    );
  }
}
