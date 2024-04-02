//Ask questions before testing
//What does the class depend on? => AuthenticationRepository
//How can we create a fake version of the dependency? => Use Mocktail
// How do we control what our dependencies do? => Using the Mocktail's APIs


import 'package:dartz/dartz.dart';
import 'package:flutter_course_app/features/authentication/domain/entities/user.dart';
import 'package:flutter_course_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_course_app/features/authentication/domain/usecases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authetication_repository.mock.dart';

void main(){
  late AuthenticationRepository repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test('should call [AuthRepo.getUsers] and return [List<User>]', () async{
    // Arrange
    when(() => repository.getUsers()).thenAnswer((_) async => const Right(tResponse),);

    //Act
    final result = await usecase();

    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}