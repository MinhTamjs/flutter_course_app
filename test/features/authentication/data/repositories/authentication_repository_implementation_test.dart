import 'package:dartz/dartz.dart';
import 'package:flutter_course_app/core/errors/exceptions.dart';
import 'package:flutter_course_app/core/errors/failure.dart';
import 'package:flutter_course_app/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_course_app/features/authentication/data/models/user_model.dart';
import 'package:flutter_course_app/features/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:flutter_course_app/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });
  const tException = APIException(
    message: 'Unknown error occured',
    statusCode: 500,
  );

  //createUser test
  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';
    test(
        'should call the [RemoteDataSource.createUser] and complete successfully when the call to the remote source is successful',
        () async {
      //Arrange
      when(
        () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')),
      ).thenAnswer((_) async => Future.value());

      //Act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      //Assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar));
    });
    test(
      'should return a [APIFailure] when the call to the remote source is unsuccessful',
      () async {
        when(
          () => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')),
        ).thenThrow(tException);
        final result = await repoImpl.createUser(
            createdAt: createdAt, name: name, avatar: avatar);
        expect(
          result,
          equals(Left(
            APIFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          )),
        );
        verify(() => remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  //getUser test
  group('getUsers', () {
    test(
      'should call the [RemoteDataSource.getUsers] and return [List<User>] when call to remote source is successful',
      () async {
        const expectedUsers = [UserModel.empty()];
        when(() => remoteDataSource.getUsers()).thenAnswer(
          (_) async => expectedUsers,
        );
        final result = await repoImpl.getUsers();
        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
        'should return a [APIFailure] when the call to the remote source is unsuccessful',
        () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);
      final result = await repoImpl.getUsers();
      expect(result, equals(Left(APIFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
