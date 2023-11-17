import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  StartupCubit({required this.userRepository}) : super(CommonInitialState());

  fetchStartUpData() async {
    emit(CommonLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    await userRepository.initialize();
    ({bool isLoggedIn}) startUpResult =
        (isLoggedIn: userRepository.token.isNotEmpty);
    emit(CommonSuccessState<({bool isLoggedIn})>(item: startUpResult));
  }
}
