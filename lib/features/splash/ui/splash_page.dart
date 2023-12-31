import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/features/splash/startup_cubit.dart';
import 'package:amazon_clone/features/splash/ui/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartupCubit(
        userRepository: context.read<UserRepository>(),
      )..fetchStartUpData(),
      child: const SplashWidget(),
    );
  }
}
