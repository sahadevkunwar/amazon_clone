import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/search/repo/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<CommonState> {
  final SearchRepo searchRepo;
  SearchCubit({required this.searchRepo}) : super(CommonInitialState());

  searchQuery({required String searchQuery}) async {
    emit(CommonLoadingState());
    final res = await searchRepo.searchProduct(searchQuery: searchQuery);
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: data)),
    );
  }
}
