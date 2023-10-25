import 'package:amazon_clone/features/auth/data_source/login_source.dart';
import 'package:dartz/dartz.dart';

class LoginRepo {
  final LoginSource loginSource;
  LoginRepo({required this.loginSource});

Future<Either<String, void>>  loginUser({required String email, required String password}) async {
  return  await loginSource.loginUser(email: email, password: password);
  }
}
