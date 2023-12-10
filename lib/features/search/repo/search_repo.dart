import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SearchRepo {
  final UserRepository userRepository;
  SearchRepo({required this.userRepository});

  Future<Either<String, List<Product>>> searchProduct({
    required String searchQuery,
  }) async {
    try {
      final Dio dio = Dio();
      List<Product> searchList = [];
      final Map<String, dynamic> header = {
        "x-auth-token": userRepository.token,
      };
      final res = await dio.get(
        '${GlobalVariables.baseUrl}/api/products/search/$searchQuery',
        options: Options(headers: header),
      );

      searchList = List.from(res.data).map((e) => Product.fromMap(e)).toList();
      return Right(searchList);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to search product");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
