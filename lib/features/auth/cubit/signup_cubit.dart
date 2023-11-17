import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/auth/data_source/signup_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<CommonState> {
  final SignupRepository signupRepository;
  SignupCubit({required this.signupRepository}) : super(CommonInitialState());

  signupUser({
    required String email,
    required String name,
    required String password,
  }) async {
    emit(CommonLoadingState());
    final res = await signupRepository.signupUser(
      email: email,
      name: name,
      password: password,
    );
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }
}
