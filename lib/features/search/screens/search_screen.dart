import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/common/widgets/empty_task.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazon_clone/features/search/cubit/search_cubit.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().searchQuery(searchQuery: widget.searchQuery);
  }

  void navigateToSearchScreen(String query) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchScreen(searchQuery: query),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 23,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
              IconButton(
                  onPressed: () {
                    context.read<UserRepository>().logout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const AuthScreen()),
                        (route) => false);
                  },
                  icon: const Icon(Icons.logout_outlined))
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const AddressBox(),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<SearchCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonErrorState) {
                  return Center(child: Text(state.message));
                } else if (state is CommonSuccessState<List<Product>>) {
                  return state.item.isEmpty
                      ? const EmptyTask()
                      : ListView.builder(
                          itemCount: state.item.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   ProductDetailScreen.routeName,
                                //   arguments: products![index],
                                // );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailScreen(
                                        product: state.item[index]),
                                  ),
                                );
                              },
                              child: SearchedProduct(
                                product: state.item[index],
                              ),
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
    );
  }
}
