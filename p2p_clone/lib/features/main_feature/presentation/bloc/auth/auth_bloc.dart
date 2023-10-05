import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:p2p_clone/core/failure/failure.dart';
import 'package:p2p_clone/features/main_feature/domain/entities/user.dart';
import 'package:p2p_clone/features/main_feature/domain/use_case/auth_with_creds_use_case.dart';
import 'package:p2p_clone/features/main_feature/domain/use_case/auth_with_fingerprint_use_case.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthWithCredsUseCase authWithCredsUseCase;
  final AuthWithFindgerprintUseCase authWithFindgerprintUseCase;
  AuthBloc({
    required this.authWithCredsUseCase,
    required this.authWithFindgerprintUseCase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(AuthLoading());
        final result = await authWithCredsUseCase(
          event.username,
          event.password,
        );
        result.fold(
          (failure) => emit(AuthError(failure: failure)),
          (user) => emit(AuthSuccess(user: user)),
        );
      } else if (event is FingerPrintUnlockEvent) {
        emit(AuthLoading());
        final result = await authWithFindgerprintUseCase();
        result.fold(
          (failure) => emit(AuthError(failure: failure)),
          (user) => emit(AuthSuccess(user: user)),
        );
      }
    });
  }
}
