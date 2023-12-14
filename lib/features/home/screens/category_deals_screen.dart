import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/common/widgets/empty_task.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/screens/widgets/product_card.dart';
import 'package:amazon_clone/features/home/cubit/fetch_product_category.dart';
import 'package:amazon_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList = [];
  @override
  void initState() {
    context
        .read<FetchProductCategoryCubit>()
        .fetchCategoryProduct(category: widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: BlocListener<FetchProductCategoryCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonErrorState) {
            showSnackBar(
              context: context,
              text: state.message,
              backgroundColor: Colors.red,
            );
          }
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                'Keep shopping for ${widget.category}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<FetchProductCategoryCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonErrorState) {
                    return Center(child: Text(state.message));
                  } else if (state is CommonSuccessState<List<Product>>) {
                    return state.item.isEmpty
                        ? const EmptyTask()
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Set the number of columns
                              crossAxisSpacing:
                                  8.0, // Set the spacing between columns
                              mainAxisSpacing: 10.0,
                              childAspectRatio:
                                  0.7, // Set the spacing between rows
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
          ],
        ),
      ),
    );
  }
}
