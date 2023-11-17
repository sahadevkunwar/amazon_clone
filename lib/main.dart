import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/cubit/login_cubit.dart';
import 'package:amazon_clone/features/auth/cubit/signup_cubit.dart';
import 'package:amazon_clone/features/auth/data_source/signup_repo.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/features/splash/ui/splash_page.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => SignupRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              signupRepository: context.read<SignupRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amazon clone',
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          onGenerateRoute: (settings) => generateRoute(settings),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
