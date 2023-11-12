import 'package:amazon_clone/features/auth/data_source/login_source.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:dartz/dartz.dart';

class LoginRepo {
  final LoginSource loginSource;
  LoginRepo({required this.loginSource});

  Future<Either<String, String>> loginUser(
      {required String email, required String password}) async {
    return await loginSource.loginUser(email: email, password: password);
  }

  Future<Either<String, User>> getUserData(String? token) async {
    return await loginSource.getUserData(token!);
  }
}
