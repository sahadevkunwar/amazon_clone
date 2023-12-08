import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/home/home_repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchProductCategoryCubit extends Cubit<CommonState> {
  final HomeRepo homeRepo;
  FetchProductCategoryCubit({required this.homeRepo}) : super(CommonInitialState());

  fetchCategoryProduct({required String category}) async {
    emit(CommonLoadingState());
    final res = await homeRepo.fetchCategoryProduct(category: category);
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: data)),
    );
  }
}
