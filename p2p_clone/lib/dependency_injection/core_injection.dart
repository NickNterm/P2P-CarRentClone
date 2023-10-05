import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:p2p_clone/core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_injection.dart';

Future<void> initCore() async {
  // init the dependencies for the core module
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl(),
    ),
  );
  sl.registerLazySingleton<LocalAuthentication>(
    () => LocalAuthentication(),
  );
}
