class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure() : super('Server Failure');
}

class CacheFailure extends Failure {
  const CacheFailure() : super('Cache Failure');
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Network Failure');
}
