import 'package:amazon_clone/features/auth/data_source/login_source.dart';

class LoginRepo {
  final LoginSource loginSource;
  LoginRepo({required this.loginSource});

  loginUser({required String email, required String password}) async {
    try {
      await loginSource.loginUser(email: email, password: password);
    } catch (e) {}
  }
}
