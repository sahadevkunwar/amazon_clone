import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/product_details/repo/product_detail_repo.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartCubit extends Cubit<CommonState> {
  final ProductDetailRepo productDetailRepo;
  AddToCartCubit({required this.productDetailRepo})
      : super(CommonInitialState());

  addToCart({required Product product}) async {
    emit(CommonLoadingState());
    final res = await productDetailRepo.addToCart(product: product);
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }
}
