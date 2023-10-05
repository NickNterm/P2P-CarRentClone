import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/data/model/user_model.dart';
import 'package:p2p_clone/features/main_feature/domain/repository/auth_repository.dart';

class AuthWithFindgerprintUseCase {
  final AuthRepository authRepository;

  AuthWithFindgerprintUseCase({
    required this.authRepository,
  });

  Future<Either<Failure, UserModel>> call() async {
    return await authRepository.fingerPrintUnlock();
  }
}
