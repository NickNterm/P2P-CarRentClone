import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:p2p_clone/features/main_feature/data/model/user_model.dart';

import '../../../../json/reader.dart';

class MockUserModel extends Mock implements UserModel {}

void main() {
  late MockUserModel mockUserModel;
  UserModel userModel = UserModel.testDefault();
  setUp(() {
    mockUserModel = MockUserModel();
  });

  test('should be a subclass of User entity', () async {
    // assert
    expect(mockUserModel, isA<UserModel>());
  });

  test('should return a valid model when the JSON is correct', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture('user.json'),
    );
    // act
    final result = UserModel.fromJson(jsonMap);
    // assert
    expect(result, userModel);
  });

  test('should return a valid JSON String containing the proper data',
      () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture('user.json'),
    );
    // act
    final result = jsonDecode(
      userModel.toJson(),
    );
    // assert
    expect(result, jsonMap);
  });
}
