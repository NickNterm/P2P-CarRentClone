part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess({
    required this.user,
  });
}

class AuthError extends AuthState {
  final Failure failure;

  AuthError({
    required this.failure,
  });
}
