import 'package:get_it/get_it.dart';
import 'package:p2p_clone/dependency_injection/auth_injection.dart';
import 'package:p2p_clone/dependency_injection/car_injection.dart';
import 'package:p2p_clone/dependency_injection/core_injection.dart';

final sl = GetIt.instance;
Future<void> init() async {
  await initCore();
  await initCars();
  await initAuth();
}
