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
    print('token: $token');
    return sharedPreferences.setString('token', token);
  }

  @override
  Future<String> getToken() async {
    print('token is: ${sharedPreferences.getString('token')}');
    return sharedPreferences.getString('token') ?? '';
  }

  @override
  Future<bool> authWithFingerPrint() async {
    if (await localAuthentication.canCheckBiometrics) {
      print('can check biometrics');
      final result = await localAuthentication.authenticate(
        localizedReason: 'Please authenticate to login',
      );
      return result;
    }
    print('can not check biometrics');
    return false;
  }
}
