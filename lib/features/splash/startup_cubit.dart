import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/auth/data_source/login_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupCubit extends Cubit<CommonState> {
  final LoginSource loginSource;
  StartupCubit({required this.loginSource}) : super(CommonInitialState());

  fetchStartUpData() async {
    emit(CommonLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    await loginSource.initialize();
    ({bool isLoggedIn}) startUpResult =
        (isLoggedIn: loginSource.token.isNotEmpty);
    emit(CommonSuccessState<({bool isLoggedIn})>(item: startUpResult));
  }
}
