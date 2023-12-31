import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/rating_bar.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/product_details/cubit/add_to_cart_cubit.dart';
import 'package:amazon_clone/features/product_details/cubit/product_detail_cubit.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  double avgRating = 0.0;
  double myRating = 0.0;
  @override
  void initState() {
    super.initState();
    double totalRating = 0.0;
    for (var i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          context.read<UserRepository>().user?.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchScreen(searchQuery: query),
    ));
  }

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonErrorState) {
          showSnackBar(
            context: context,
            text: state.message,
            backgroundColor: Colors.red,
          );
        }
        if (state is CommonSuccessState) {
          showSnackBar(
            context: context,
            text: 'Product added to cart',
            backgroundColor: Colors.green,
          );
        }
      },
      child: Scaffold(
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
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(
                                    searchQuery: searchController.text,
                                  ),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
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
        body: SingleChildScrollView(
          child: BlocListener<ProductDetailCubit, CommonState>(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.id!),
                      Stars(rating: avgRating),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                CarouselSlider(
                  items: widget.product.images.map((i) {
                    return Builder(
                      builder: (BuildContext context) => Image.network(
                        i,
                        fit: BoxFit.contain,
                        height: 200,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 300,
                  ),
                ),
                Container(height: 5, color: Colors.black12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                        text: 'Deal Price: ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '\$${widget.product.price}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          )
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.product.description),
                ),
                Container(height: 5, color: Colors.black12),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Buy Now',
                    onTap: () {},
                    backColors: Colors.amber,
                    foreColor: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Add to Cart',
                    onTap: () {
                      context
                          .read<AddToCartCubit>()
                          .addToCart(product: widget.product);
                    },
                    backColors: Colors.orange,
                    foreColor: Colors.white,
                  ),
                ),
                Container(height: 5, color: Colors.black12),
                const Text(
                  'Rate The Product',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RatingBar.builder(
                  initialRating: myRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: GlobalVariables.secondaryColor,
                  ),
                  onRatingUpdate: (rating) {
                    context.read<ProductDetailCubit>().rateProduct(
                          product: widget.product,
                          rating: rating,
                        );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
