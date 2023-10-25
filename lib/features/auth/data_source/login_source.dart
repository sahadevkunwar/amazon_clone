import 'dart:convert';

import 'package:amazon_clone/common/utils/shared_prefs.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class LoginSource {
  // User _user =
  //     User(id: '', name: '', email: '', password: '', type: '', token: '');
  // User get user => _user;

  // set setUser(String user) {
  //   _user = User.fromMap(jsonDecode(user));
  // }
  User? _user;
  User? get user => _user;

  Future<Either<String, void>> loginUser(
      {required String email, required String password}) async {
    try {
      final Dio dio = Dio();
      final res = await dio.post(
        "${GlobalVariables.baseUrl}/api/signin",
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      final tempUser = User.fromMap(res.data);
      // await SharedPrefUtisl.saveToken(jsonEncode(res.data));
      _user = tempUser;
      await SharedPrefUtisl.saveUser(tempUser);

      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to signin");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
