import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/admin/screens/widgets/product_card.dart';
import 'package:amazon_clone/features/home/cubit/fetch_deal_of_day_cubit.dart';
import 'package:amazon_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return const CupertinoActivityIndicator();
            }
          },
        ),
      ],
    );
  }
}
