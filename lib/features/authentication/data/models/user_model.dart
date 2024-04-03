import 'dart:convert';

import 'package:flutter_course_app/core/utils/typedef.dart';
import 'package:flutter_course_app/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.avatar,
    required super.createdAt,
    required super.name,
  });

  const UserModel.empty()
      : this(
          id: '1',
          avatar: 'empty.avatar',
          createdAt: 'empty.createdAt',
          name: 'empty.name',
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          avatar: map['avatar'] as String,
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
        );
  UserModel copyWith({
    String? avatar,
    String? id,
    String? createdAt,
    String? name,
  }) {
    return UserModel(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name);
  }

  DataMap toMap() => {
        'id': id,
        'avatar': avatar,
        'createdAt': createdAt,
        'name': name,
      };
  String toJson() => jsonEncode(toMap());
}
