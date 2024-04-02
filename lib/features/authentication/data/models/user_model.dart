import 'package:flutter_course_app/core/utils/typedef.dart';
import 'package:flutter_course_app/features/authentication/domain/entities/user.dart';

class UserModel extends User{
  const UserModel({
    required super.avatar,
    required super.id,
    required super.createdAt,
    required super.name,
  });

  UserModel.fromMap(DataMap map) : this(avatar: map['avatar'] as String, id: map['id'] as int, createdAt: map['createdAt'] as String, name: map['name'] as String,);
    
}