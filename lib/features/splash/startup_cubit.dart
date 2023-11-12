import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/common/utils/shared_prefs.dart';
import 'package:amazon_clone/features/auth/data_source/login_source.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupCubit extends Cubit<CommonState> {
  final LoginSource loginSource;
  StartupCubit({required this.loginSource}) : super(CommonInitialState());

  fetchStartUpData() async {
    User user;
    user = (await SharedPrefUtisl.getUser())!;
    emit(CommonLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    //await loginSource.initialize();
    // ({User? isLoggedIn}) startUpResult = (isLoggedIn: user);
    emit(CommonSuccessState<User>(item: user));
  }
}
