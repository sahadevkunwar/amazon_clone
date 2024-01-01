import 'dart:convert';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
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

  Future<Either<String, void>> addToCart({
    required Product product,
  }) async {
    try {
      // int productQuantity = 0;
      final Dio dio = Dio();
      final res = await dio.post('${GlobalVariables.baseUrl}/api/add-to-cart',
          options: Options(
            headers: {'x-auth-token': userRepository.token},
          ),
          data: jsonEncode(
            {'id': product.id},
          ));
      // print('------------------------------------');
      // print(res.data);
      // print('------------------------------------');

      ///[Working code]
      User updatedUser = userRepository.user!.copyWith(cart: res.data['cart']);
      userRepository.setUser(updatedUser);

      ///[Test code for directly quantity]
      // final user = User.fromMap(res.data);
      // List<dynamic>? cart = user.cart;

      // if (cart != null) {
      //   //Iterate through cart items
      //   for (var cartItem in cart) {
      //     // Access product quantity and other details
      //     productQuantity = cartItem['quantity'];
      //   }
      // }
      // print(productQuantity);

      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data['error']);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> removeFromCart({
    required Product product,
  }) async {
    try {
      final Dio dio = Dio();
      final res = await dio.delete(
        '${GlobalVariables.baseUrl}/api/remove-from-cart/${product.id}',
        options: Options(
          headers: {'x-auth-token': userRepository.token},
        ),
      );
      User updatedUser = userRepository.user!.copyWith(cart: res.data['cart']);
      // Assuming the response contains updated user data after adding to cart
      // Update the user in UserRepository
      userRepository.setUser(updatedUser);
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data['error']);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
