import 'package:amazon_clone/bootstrap.dart';
import 'package:amazon_clone/features/auth/cubit/login_cubit.dart';
import 'package:amazon_clone/features/auth/cubit/signup_cubit.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<SignupCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<LoginCubit>(),
        ),
      ],
      child: const AuthScreenWidget(),
    );
  }
}
