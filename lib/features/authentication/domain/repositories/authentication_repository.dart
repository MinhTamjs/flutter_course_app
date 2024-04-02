import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_course_app/core/errors/failure.dart';
import 'package:flutter_course_app/core/utils/typedef.dart';
import 'package:flutter_course_app/features/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository{
  const AuthenticationRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar
  });

  ResultFuture<List<User>> getUsers();
}