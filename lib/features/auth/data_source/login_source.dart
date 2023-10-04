import 'dart:convert';

import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class LoginSource {
  loginUser({required String email, required String password}) async {
    try {
      final Dio dio = Dio();
      final res = await dio.post(
        "${GlobalVariables.baseUrl}/api/signin",
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      print(res.data);
    } catch (e) {}
  }
}
