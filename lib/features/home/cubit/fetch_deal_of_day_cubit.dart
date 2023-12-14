import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/home/home_repo/home_repo.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealOfDayCubit extends Cubit<CommonState> {
  final HomeRepo homeRepo;
  DealOfDayCubit({required this.homeRepo}) : super(CommonInitialState());

  fetchDealOfDay() async {
    emit(CommonLoadingState());
    final res = await homeRepo.fetchDealOfDay();
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState<Product>(item: data)),
    );
  }
}
