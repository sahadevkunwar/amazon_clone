import 'package:get_it/get_it.dart';

import 'features/auth/cubit/signup_cubit.dart';
import 'features/auth/data_source/signup_source.dart';
import 'features/auth/repo/signup_repo.dart';

GetIt getIt = GetIt.instance;
Future<void> bootstrap() async {
  ///[Signup Singleton]
  getIt.registerLazySingleton<SignupSource>(() => SignupSource());
  getIt.registerLazySingleton<SignupRepository>(
      () => SignupRepository(userSource: getIt<SignupSource>()));
  getIt.registerLazySingleton<SignupCubit>(
      () => SignupCubit(signupRepository: getIt<SignupRepository>()));
}
