import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/auth/repo/login_repo.dart';
import 'package:amazon_clone/models/user.dart';
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
      (error) => emit(
        CommonErrorState(message: error.toString()),
      ),
      (data) async {
        final userOrError = await loginRepo.getUserData(data);

        userOrError.fold(
          (error) => emit(CommonErrorState(message: error)),
          (data) => emit(CommonSuccessState<User>(item: data)),
        );
      },
    );
  }
}
// res.fold(
//       (error) => emit(CommonErrorState(message: error)),
//       (data) async {
//         final dataOrError = await _loginRepo.getUser(data);
//         userOrError.fold(
//           (error) => emit(CommonErrorState(message: error)),
//           (user) {
//             if (user != null) {
//               emit(CommonSuccessState<User>(item: user));
//             } else {
//               emit(CommonErrorState(message: "Failed to fetch user data"));
//             }
//           },
//         );
//       },
//     );