import 'dart:convert';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProductDetailRepo {
  final UserRepository userRepository;
  ProductDetailRepo({required this.userRepository});

  Future<Either<String, Product>> rateProduct({
    required Product product,
    required double rating,
  }) async {
    try {
      final Dio dio = Dio();
      final res = await dio.post('${GlobalVariables.baseUrl}/api/rate-product',
          options: Options(
            headers: {'x-auth-token': userRepository.token},
          ),
          data: jsonEncode(
            {'id': product.id, 'rating': rating},
          ));
      final tempProduct = Product.fromMap(res.data);
      return Right(tempProduct);
    } on DioException catch (e) {
      return Left(e.response?.data['error']);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
