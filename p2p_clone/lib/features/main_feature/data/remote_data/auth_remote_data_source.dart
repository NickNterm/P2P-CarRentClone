abstract class AuthRemoteDataSource {
  Future<String> login(String username, String password);
}

// This code is not tested for simplicity
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<String> login(String username, String password) async {
    // TODO here we need to add api call that returns a JWT token and save it localy.
    // Then the face id and fingerprint ensures that the users is there and use
    // the JWT to make the api requests
    // For simplicity i use username as a token to test it out

    return username;
  }
}
