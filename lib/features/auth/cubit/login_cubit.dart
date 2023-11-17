import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  LoginCubit({required this.userRepository}) : super(CommonInitialState());

  loginUser({
    required String email,
    required String password,
  }) async {
    emit(CommonLoadingState());
    final res = await userRepository.loginUser(
      email: email,
      password: password,
    );

    res.fold(
      (error) => emit(
        CommonErrorState(message: error.toString()),
      ),
      (data) async {
        final userOrError = await userRepository.getUserData(data);

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