import 'package:bloc/bloc.dart';
//import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_course_app/features/authentication/domain/entities/user.dart';
import 'package:flutter_course_app/features/authentication/domain/usecases/create_user.dart';
import 'package:flutter_course_app/features/authentication/domain/usecases/get_users.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createUser(
      CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar,
      ),
    );
    result.fold(
        (failure) => emit(AuthenticationError(
            '${failure.statusCode} Error: ${failure.message}')),
        (_) => emit(const UserCreated()));
  }

  Future<void> _getUsersHandler(
    GetUsersEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const GettingUsers());
    final result = await _getUsers();
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (users) => emit(UsersLoaded(users)));
  }
}
