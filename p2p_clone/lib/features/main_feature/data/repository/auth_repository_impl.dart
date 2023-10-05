import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/core/network/network_info.dart';
import 'package:p2p_clone/features/main_feature/data/local_data/auth_local_data_source.dart';
import 'package:p2p_clone/features/main_feature/data/model/user_model.dart';
import 'package:p2p_clone/features/main_feature/data/remote_data/auth_remote_data_source.dart';
import 'package:p2p_clone/features/main_feature/domain/repository/auth_repository.dart';

// Not tested Code for the sake of simplicity and time pressure
class AuthRepositoryImpl extends AuthRepository {
  AuthLocalDataSource authLocalDataSource;
  AuthRemoteDataSource authRemoteDataSource;
  NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authLocalDataSource,
    required this.authRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, UserModel>> fingerPrintUnlock() async {
    if (await authLocalDataSource.getToken() != '') {
      // if the user had logged in before, try to login with fingerPrint
      try {
        final result = await authLocalDataSource.authWithFingerPrint();
        // if the fingerPrint is correct, return the user from the token
        if (result) {
          return Right(
            UserModel.fromToken(
              await authLocalDataSource.getToken(),
            ),
          );
        }
        return const Left(
          Failure("Auth Fail"),
        );
      } catch (_) {
        return const Left(
          Failure("Auth Fail"),
        );
      }
    } else {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> login(
    String username,
    String password,
  ) async {
    if (await networkInfo.isConnected) {
      // if there is network connection, login with the api
      final result = await authRemoteDataSource.login(username, password);
      // cache the token locally
      authLocalDataSource.cacheToken(result);
      return Right(UserModel.fromToken(result));
    } else {
      // else there is no way to login
      return const Left(NetworkFailure());
    }
  }
}
