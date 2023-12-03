import 'dart:async';

import 'package:amazon_clone/common/bloc/common_state.dart';
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
  Completer<bool> _refreshCompleter = Completer<bool>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FetchProductCubit, CommonState>(
        listener: (context, state) {
          if (state is! CommonLoadingState &&
              _refreshCompleter.isCompleted == false) {
            _refreshCompleter.complete(true);
          }
        },
        buildWhen: (previous, current) {
          if (current is CommonLoadingState) {
            return current.showLoading;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          return BlocBuilder<FetchProductCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonErrorState) {
                return Center(child: Text(state.message));
              }
              if (state is CommonSuccessState<List<Product>>) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _refreshCompleter = Completer<bool>();
                    context.read<FetchProductCubit>().fetchAllProduct();
                    await _refreshCompleter.future;
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: state.item.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: state.item[index],
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: CupertinoActivityIndicator());
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductScreen()));
        },
        tooltip: "Add a product",
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
