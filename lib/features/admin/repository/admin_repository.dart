import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AdminRepository {
  final UserRepository userRepository;
  AdminRepository({required this.userRepository});
  final List<Product> _items = [];

  List<Product> get items => _items;
  Future<Either<String, void>> sellProduct({
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      // final String token = await SharedPrefUtisl.getToken();
      final Dio dio = Dio();
      final cloudnary = CloudinaryPublic('dnwz1vyoq', 'ry1ukruq');
      List<String> imageUrls = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudnary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        price: price,
        category: category,
      );
      final Map<String, dynamic> header = {
        // 'Content-Type': 'application/json; charset=UTF-8',
        "x-auth-token": userRepository.token,
        // "Authorization": "Bearer $token"
      };
      final _ = await dio.post("${GlobalVariables.baseUrl}/admin/add-product",
          data: jsonEncode(product.toMap()),
          options: Options(
            headers: header,
          ));
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to post product");
    } catch (e) {
      return Left(e.toString());
    }
  }

  ///get all products
  Future<Either<String, List<Product>>> fetchAllProducts() async {
    try {
      final Dio dio = Dio();
      final Map<String, dynamic> header = {
        "x-auth-token": userRepository.token,
      };
      final res = await dio.get(
        "${GlobalVariables.baseUrl}/admin/get-products",
        options: Options(
          headers: header,
        ),
      );
      //print("fetch all product $res");
      final listProduct =
          List.from(res.data).map((e) => Product.fromMap(e)).toList();
      // _items.clear();
      // _items.addAll(listProduct);

      return Right(listProduct);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to fetch product");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> deleteProduct({required String id}) async {
    try {
      final Dio dio = Dio();
      final Map<String, dynamic> header = {
        "x-auth-token": userRepository.token,
      };
      final _ = await dio.post(
        "${GlobalVariables.baseUrl}/admin/delete-product",
        options: Options(headers: header),
        data: {"id": id},
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unable to fetch product");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
