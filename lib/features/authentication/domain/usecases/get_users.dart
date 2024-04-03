import 'package:flutter_course_app/core/usecase/usecase.dart';
import 'package:flutter_course_app/core/utils/typedef.dart';
import 'package:flutter_course_app/features/authentication/domain/entities/user.dart';
import 'package:flutter_course_app/features/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
