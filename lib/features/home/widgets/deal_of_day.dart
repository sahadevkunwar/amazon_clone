import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/admin/screens/widgets/product_card.dart';
import 'package:amazon_clone/features/home/cubit/fetch_deal_of_day_cubit.dart';
import 'package:amazon_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class DealOfDay extends StatelessWidget {
  const DealOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            'Deal of the Day',
            style: TextStyle(fontSize: 20),
          ),
        ),
        BlocBuilder<DealOfDayCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonSuccessState<Product>) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: state.item),
                    ),
                  );
                },
                child: ProductCard(product: state.item),
              );
            } else if (state is CommonErrorState) {
              return Center(child: Text(state.message));
            } else {
              // return const CupertinoActivityIndicator();
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300, // Adjust the base color
                highlightColor:
                    Colors.grey.shade100, // Adjust the highlight color
                period: const Duration(
                    milliseconds:
                        1500), // Adjust the shimmer animation duration
                child: Container(
                  height: 200, // Adjust the height as needed
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust the radius as needed
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
