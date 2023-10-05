import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/data/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login(String username, String password);
  Future<Either<Failure, bool>> isRegistered();
  Future<Either<Failure, UserModel>> fingerPrintUnlock();
}
