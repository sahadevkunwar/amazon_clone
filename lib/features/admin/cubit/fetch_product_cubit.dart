import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/admin/repository/admin_repository.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchProductCubit extends Cubit<CommonState> {
  final AdminRepository adminRepository;

  FetchProductCubit({required this.adminRepository})
      : super(CommonInitialState());

  fetchAllProduct() async {
    emit(CommonLoadingState());
    final res = await adminRepository.fetchAllProducts();
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState<List<Product>>(item: data)),
    );
  }
}
