import 'package:amazon_clone/features/auth/cubit/login_cubit.dart';
import 'package:amazon_clone/features/auth/data_source/login_source.dart';
import 'package:amazon_clone/features/auth/repo/login_repo.dart';
import 'package:amazon_clone/features/splash/startup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'features/auth/cubit/signup_cubit.dart';
import 'features/auth/data_source/signup_source.dart';
import 'features/auth/repo/signup_repo.dart';

GetIt getIt = GetIt.instance;
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///[Signup Singleton]
  getIt.registerLazySingleton<SignupSource>(() => SignupSource());
  getIt.registerLazySingleton<SignupRepository>(
      () => SignupRepository(userSource: getIt<SignupSource>()));
  getIt.registerLazySingleton<SignupCubit>(
      () => SignupCubit(signupRepository: getIt<SignupRepository>()));

  ///[Signup Singleton]
  getIt.registerLazySingleton<LoginSource>(() => LoginSource());
  getIt.registerLazySingleton<LoginRepo>(
      () => LoginRepo(loginSource: getIt<LoginSource>()));
  getIt.registerLazySingleton<LoginCubit>(
      () => LoginCubit(loginRepo: getIt<LoginRepo>()));

  //[startup singleton]
  //getIt<LoginSource>().initialize();

  getIt.registerLazySingleton<StartupCubit>(
      () => StartupCubit(loginSource: getIt<LoginSource>()));
}
