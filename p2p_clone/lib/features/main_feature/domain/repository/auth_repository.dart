import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/data/model/user_model.dart';

abstract class AuthRepository {
  // Login with username and password
  Future<Either<Failure, UserModel>> login(String username, String password);

  // Login with fingerPrint only
  Future<Either<Failure, UserModel>> fingerPrintUnlock();
}
