//Ask questions before testing
//What does the class depend on? => AuthenticationRepository
//How can we create a fake version of the dependency? => Use Mocktail
// How do we control what our dependencies do? => Using the Mocktail's APIs

import 'dart:convert';
//import 'dart:io';

import 'package:flutter_course_app/core/utils/typedef.dart';
import 'package:flutter_course_app/features/authentication/data/models/user_model.dart';
import 'package:flutter_course_app/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test('should be a subclass of the [User] entity', () {
    //Arrange

    //Act

    //Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixtures('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      //Arrange

      //Act
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });
  group('fromJson', () {
    test('should return a [UserModel] with a right data', () {
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });
  group('toMap', () {
    test('should return a [Map] with the right data', () {
      //Act
      final result = tModel.toMap();
      //Assert
      expect(result, equals(tMap));
    });
  });
  group('toJson', () {
    test('should return a [JSON] string with the right data', () {
      //Act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "empty.avatar",
        "createdAt": "empty.createdAt",
        "name": "empty.name"
      });
      //Assert
      expect(result, equals(tJson));
    });
   });
  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      final result = tModel.copyWith(name: 'Paul');
      expect(result.name, equals('Paul'));
    });
   });
}
