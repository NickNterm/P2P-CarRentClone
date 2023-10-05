import 'package:dartz/dartz.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/data/model/user_model.dart';
import 'package:p2p_clone/features/main_feature/domain/repository/auth_repository.dart';

class AuthWithCredsUseCase {
  final AuthRepository authRepository;

  AuthWithCredsUseCase({
    required this.authRepository,
  });

  Future<Either<Failure, UserModel>> call(
    String username,
    String password,
  ) async {
    return await authRepository.login(username, password);
  }
}
