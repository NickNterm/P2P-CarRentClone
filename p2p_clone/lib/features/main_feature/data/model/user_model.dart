import 'package:p2p_clone/features/main_feature/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.name,
  });

  // Json to Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
    );
  }

  // Model to Json
  String toJson() {
    return '''
    {
      "name": "$name"
    }
    ''';
  }

  // Class for testing
  factory UserModel.testDefault() {
    return const UserModel(
      name: 'testName',
    );
  }

  // This code is not tested for simplicity
  // the token is just the name
  factory UserModel.fromToken(String token) {
    return UserModel(
      name: token,
    );
  }
}
