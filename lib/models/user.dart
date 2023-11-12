// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone/features/auth/model/user_role_enum.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.token,
  });
  // UserRole get currentRole {
  //   if (authorities.isEmpty) {
  //     throw Exception("Role not found");
  //   } else {
  //     for (Authority auth in authorities) {
  //       if (auth.authority.toLowerCase() == "owner") {
  //         return UserRole.owner;
  //       } else if (auth.authority.toLowerCase() == "renter") {
  //         return UserRole.renter;
  //       } else if (auth.authority.toLowerCase() == "admin") {
  //         return UserRole.admin;
  //       }
  //     }
  //     throw Exception("Role not found");
  //   }
  // }
  UserRole get currentRole {
    if (type.isEmpty) {
      throw Exception("Role not found");
    } else {
      if (type.toLowerCase() == "user") {
        return UserRole.user;
      } else if (type.toLowerCase() == "renter") {
        return UserRole.admin;
      } else if (type.toLowerCase() == "admin") {
        return UserRole.admin;
      }
    }
    throw Exception("Role not found");
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
