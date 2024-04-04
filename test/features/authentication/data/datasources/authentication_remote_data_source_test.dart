import 'dart:convert';

//import 'package:flutter/services.dart';
import 'package:flutter_course_app/core/errors/exceptions.dart';
import 'package:flutter_course_app/core/utils/constants.dart';
import 'package:flutter_course_app/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_course_app/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  //group test for createUser
  group('createUser', () {
    test('should complete successfully when the status is 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('User created successfully', 201),
      );
      final methodCall = remoteDataSource.createUser;
      expect(
          methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes);
      verify(
        () => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
            headers: {'Content-Type': 'application-json'}),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('Invalid email address', 400),
      );
      final methodCall = remoteDataSource.createUser;
      expect(
        () async => methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        throwsA(
          const APIException(message: 'Invail email address', statusCode: 400),
        ),
      );
      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  //getUsers test
  group('getUsers', () {
    const tUsers = [UserModel.empty()];
    test('should return [List<User>] when the status code is 200', () async {
      when(
        () => client.get(
          any(),
        ),
      ).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
      );
      final result = await remoteDataSource.getUsers();
      expect(result, equals(tUsers));
      verify(() => client.post(Uri.https(kBaseUrl, kGetUsersEndPoint)))
          .called(1);
      verifyNoMoreInteractions(client);
    });
    test('should throw [APIException] when the status code is not 200',
        () async {
      const tMessage = 'Sever down';
      when(
        () => client.get(
          any(),
        ),
      ).thenAnswer(
        (_) async => http.Response(tMessage, 500),
      );
      final methodCall = remoteDataSource.getUsers;
      expect(
        () => methodCall(),
        throwsA(
          const APIException(message: tMessage, statusCode: 500),
        ),
      );
      verify(() => client.post(Uri.https(kBaseUrl, kGetUsersEndPoint)))
          .called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
