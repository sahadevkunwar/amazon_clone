import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/admin/repository/admin_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteCubit extends Cubit<CommonState> {
  final AdminRepository adminRepository;

  DeleteCubit({required this.adminRepository}) : super(CommonInitialState());

  deleteProduct({required String id}) async {
    emit(CommonLoadingState());
    final res = await adminRepository.deleteProduct(id: id);
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }
}
