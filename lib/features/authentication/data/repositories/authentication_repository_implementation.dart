import 'package:dartz/dartz.dart';
import 'package:flutter_course_app/core/errors/exceptions.dart';
import 'package:flutter_course_app/core/errors/failure.dart';
import 'package:flutter_course_app/core/utils/typedef.dart';
import 'package:flutter_course_app/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_course_app/features/authentication/domain/entities/user.dart';
import 'package:flutter_course_app/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);
  final AuthenticationRemoteDataSource _remoteDataSource;
  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // Test-Driven Development
    // call the remote data resource
    // make sure that it returns the proper data if there is no exception
    // check if the method returns the proper data
    // check if when the remoteDataSoure throws an exception, we return a
    // failure and if it does not throw and exception, we return the actual
    // exception data
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
