import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/cubit/delete_cubit.dart';
import 'package:amazon_clone/features/admin/cubit/fetch_product_cubit.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/screens/widgets/product_card.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreenWidget extends StatefulWidget {
  const PostScreenWidget({super.key});

  @override
  State<PostScreenWidget> createState() => _PostScreenWidgetState();
}

class _PostScreenWidgetState extends State<PostScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DeleteCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonErrorState) {
            showSnackBar(
              context: context,
              text: state.message,
              backgroundColor: Colors.red,
            );
          }
          if (state is CommonSuccessState) {
            context.read<FetchProductCubit>().fetchAllProduct();
            showSnackBar(
              context: context,
              text: 'Product deleted successfully',
              backgroundColor: Colors.green,
            );
          }
        },
        child: BlocBuilder<FetchProductCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonErrorState) {
              return Center(child: Text(state.message));
            }
            if (state is CommonSuccessState<List<Product>>) {
              return GridView.builder(
                // controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Set the number of columns
                  crossAxisSpacing: 5.0, // Set the spacing between columns
                  mainAxisSpacing: 5.0, // Set the spacing between rows
                ),
                padding: const EdgeInsets.all(5),
                itemCount: state.item.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: state.item[index],
                  );
                },
              );
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductScreen()));
        },
        tooltip: "Add a product",
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
