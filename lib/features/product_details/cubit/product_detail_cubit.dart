import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/product_details/repo/product_detail_repo.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailCubit extends Cubit<CommonState> {
  final ProductDetailRepo productDetailRepo;
  ProductDetailCubit({required this.productDetailRepo})
      : super(CommonInitialState());

  rateProduct({
    required Product product,
    required double rating,
  }) async {
    emit(CommonLoadingState());
    final res =
        await productDetailRepo.rateProduct(product: product, rating: rating);
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: data)),
    );
  }
}
