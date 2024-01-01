import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/product_details/repo/product_detail_repo.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoveFromCartCubit extends Cubit<CommonState> {
  final ProductDetailRepo productDetailRepo;
  RemoveFromCartCubit({required this.productDetailRepo})
      : super(CommonInitialState());

  removeFromCart({required Product product}) async {
    emit(CommonLoadingState());
    final res = await productDetailRepo.removeFromCart(product: product);
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }
}
