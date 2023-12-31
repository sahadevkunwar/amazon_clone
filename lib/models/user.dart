import 'dart:convert';
import 'package:amazon_clone/features/auth/model/user_role_enum.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String token;
  final List<dynamic>? cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.token,
    this.cart,
  });
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }

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
      'cart': cart,
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
      cart: (map['cart'] as List<dynamic>?)
          ?.map<Map<String, dynamic>>(
            (x) => Map<String, dynamic>.from(x),
          )
          .toList(),
      //wrong way
      // cart: List<Map<String, dynamic>>.from(
      //   map['cart']?.map(
      //     (x) => Map<String, dynamic>.from(x),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
