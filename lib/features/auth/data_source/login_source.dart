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

  Future<Either<String, User>> getUserData(String token) async {
    try {
      Dio dio = Dio();
      // _token = await SharedPrefUtisl.getToken();
      var tokenRes = await dio.post("${GlobalVariables.baseUrl}/tokenIsValid",
          options: Options(headers: {
            'x-auth-token': token,
            'Content-Type': 'application/json',
          }));
      var response = jsonEncode(tokenRes.data);
      if (response == 'true') {
        final userRes = await dio.get("${GlobalVariables.baseUrl}/",
            options: Options(headers: {
              'x-auth-token': token,
              'Content-Type': 'application/json',
            }));
        final tempUser = User.fromMap(userRes.data);
        _user = tempUser;
        await SharedPrefUtisl.saveUser(tempUser);
      }

      //_user = User.fromMap(jsonDecode(userRes as String));
      // _user = User.fromMap(json.decode(userRes));

      // await SharedPrefUtisl.saveUser(_user!);

      await SharedPrefUtisl.saveToken(json.encode(user!.token));
      return Right(user!);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to signin");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> loginUser(
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
      // final tempUser = User.fromMap(jsonDecode(res.data));
      final tempUser = User.fromMap(res.data);
      // await SharedPrefUtisl.saveToken(jsonEncode(res.data));
      _user = tempUser;
      // await SharedPrefUtisl.saveUser(tempUser);
      //await SharedPrefUtisl.saveToken(tmpToken);

      return Right(user!.token);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to signin");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
