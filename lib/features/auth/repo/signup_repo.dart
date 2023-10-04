import 'package:amazon_clone/features/auth/data_source/signup_source.dart';
import 'package:dartz/dartz.dart';

class SignupRepository {
  final SignupSource userSource;
  SignupRepository({required this.userSource});
  Future<Either<String, void>> signupUser({
    required String email,
    required String name,
    required String password,
  }) async {
    return await userSource.signupUser(
      email: email,
      name: name,
      password: password,
    );
  }
}
