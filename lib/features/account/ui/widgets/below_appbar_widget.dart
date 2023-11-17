import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BelowAppBar extends StatefulWidget {
  const BelowAppBar({
    super.key,
  });

  @override
  State<BelowAppBar> createState() => _BelowAppBarState();
}

class _BelowAppBarState extends State<BelowAppBar> {
  @override
  Widget build(BuildContext context) {
    final userRepo = context.read<UserRepository>();
    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: "Hello !!! ",
                style: const TextStyle(fontSize: 22, color: Colors.black),
                children: [
                  TextSpan(
                    text: userRepo.user?.name,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
