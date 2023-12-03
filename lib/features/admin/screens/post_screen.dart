import 'package:amazon_clone/features/admin/cubit/fetch_product_cubit.dart';
import 'package:amazon_clone/features/admin/repository/admin_repository.dart';
import 'package:amazon_clone/features/admin/screens/widgets/post_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchProductCubit(
        adminRepository: context.read<AdminRepository>(),
      )..fetchAllProduct(),
      child: const PostScreenWidget(),
    );
  }
}
