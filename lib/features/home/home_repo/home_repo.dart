import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  final UserRepository userRepository;

  HomeRepo({required this.userRepository});
  Future<Either<String, List<Product>>> fetchCategoryProduct(
      {required String category}) async {
    try {
      final Dio dio = Dio();
      List<Product> productList = [];
      final Map<String, dynamic> header = {
        "x-auth-token": userRepository.token,
      };
      final res = await dio.get(
        '${GlobalVariables.baseUrl}/api/products?category=$category',
        options: Options(headers: header),
      );

      productList = List.from(res.data).map((e) => Product.fromMap(e)).toList();
      return Right(productList);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to fetch product");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
