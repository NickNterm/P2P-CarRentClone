import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> cacheToken(String token);
  Future<String> getToken();
  Future<bool> authWithFingerPrint();
}

// This code is not tested for simplicity
class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  SharedPreferences sharedPreferences;
  LocalAuthentication localAuthentication;

  AuthLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.localAuthentication,
  });

  @override
  Future<bool> cacheToken(String token) async {
    // cache the token to the shared preferences
    return sharedPreferences.setString('token', token);
  }

  @override
  Future<String> getToken() async {
    // return the token from the shared preferences
    return sharedPreferences.getString('token') ?? '';
  }

  @override
  Future<bool> authWithFingerPrint() async {
    // authenticate with fingerPrint
    // check if the device has fingerPrint
    if (await localAuthentication.canCheckBiometrics) {
      // then try to login with fingerPrint
      final result = await localAuthentication.authenticate(
        localizedReason: 'Please authenticate to login',
      );
      return result;
    }
    return false;
  }
}
