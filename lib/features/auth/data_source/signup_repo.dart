import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

class SignupRepository {
  Future<Either<String, void>> signupUser({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final Dio dio = Dio();
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        type: '',
        token: '',
      );
      await dio.post(
        "${GlobalVariables.baseUrl}/api/signup",
        data: user.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to signup");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
