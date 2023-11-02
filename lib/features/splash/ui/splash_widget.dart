import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/screens/home_screen.dart';
import 'package:amazon_clone/features/splash/startup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) {
    
    return BlocListener<StartupCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccessState<({bool isLoggedIn})>) {
          if (state.item.isLoggedIn) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          }
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AuthScreen()),
              (route) => false);
        }
      },
      child: const Scaffold(
        body: Center(child: Text("Amazon clone")),
      ),
    );
  }
}
