import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/auth/repo/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<CommonState> {
  final LoginRepo loginRepo;
  LoginCubit({required this.loginRepo}) : super(CommonInitialState());

  loginUser({
    required String email,
    required String password,
  }) async {
    emit(CommonLoadingState());
    final res = await loginRepo.loginUser(
      email: email,
      password: password,
    );
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }
}
