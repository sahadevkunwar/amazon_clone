import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/features/auth/model/user_role_enum.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
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
    final tmpUser = context.read<UserRepository>();
    return BlocListener<StartupCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccessState<({bool isLoggedIn})>) {
          if (state.item.isLoggedIn) {
            final userRole = tmpUser.user?.currentRole;
            if (userRole == UserRole.user) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const BottomBar()),
                (route) => false,
              );
            } else if (userRole == UserRole.admin) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AdminScreen()),
                (route) => false,
              );
            }
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AuthScreen()),
              (route) => false,
            );
          }
          // if (state.item.isLoggedIn) {
          //     final userRole =  state.item.currentRole;
          //   Navigator.of(context).pushAndRemoveUntil(
          //       MaterialPageRoute(builder: (context) => const BottomBar()),
          //       (route) => false);
          // } else {
          //   Navigator.of(context).pushAndRemoveUntil(
          //       MaterialPageRoute(builder: (context) => const AuthScreen()),
          //       (route) => false);
          // }
          // else if (state.item.currentRole == UserRole.admin) {
          //   Navigator.of(context).pushAndRemoveUntil(
          //       MaterialPageRoute(builder: (context) => const AdminScreen()),
          //       (route) => false);
          // }
        }
      },
      child: const Scaffold(
        body: Center(child: Text("Amazon clone")),
      ),
    );
  }
}
