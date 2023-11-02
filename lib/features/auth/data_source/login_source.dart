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
  String _token = '';
  String get token => _token;
  Future initialize() async {
    final appToken = await SharedPrefUtisl.getToken();
    _token = appToken;
    await getUserData();
  }

  Future logout() async {
    await SharedPrefUtisl.removeToken();
    _token = "";
    _user = null;
  }

  Future<Either<String, void>> getUserData() async {
    try {
      Dio dio = Dio();
      _token = await SharedPrefUtisl.getToken();
      var tokenRes = await dio.post("${GlobalVariables.baseUrl}/tokenIsValid",
          options: Options(headers: {
            'x-auth-token': token,
            'Content-Type': 'application/json',
          }));
      var response = jsonDecode(tokenRes.data);
      if (response == true) {
        final userRes = await dio.get("${GlobalVariables.baseUrl}/",
            options: Options(headers: {
              'x-auth-token': token,
              'Content-Type': 'application/json',
            }));
        _user = User.fromMap(userRes as Map<String, dynamic>);
      }

      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to signin");
    } catch (e) {
      return Left(e.toString());
    }
  }

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
      final tmpToken = jsonEncode(res.data['token']);
      _token = tmpToken;
      final tempUser = User.fromMap(res.data);
      // await SharedPrefUtisl.saveToken(jsonEncode(res.data));
      _user = tempUser;
      await SharedPrefUtisl.saveUser(tempUser);
      await SharedPrefUtisl.saveToken(tmpToken);

      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to signin");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
