import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartSubtotal extends StatefulWidget {
  const CartSubtotal({super.key});

  @override
  State<CartSubtotal> createState() => _CartSubtotalState();
}

class _CartSubtotalState extends State<CartSubtotal> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>().user;
    int sum = 0;
    user!.cart
        ?.map((e) => sum += e['quantity'] + e['product']['price'] as int)
        .toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Subtotal: ',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '\$$sum',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ) 
        ],
      ),
    );
  }
}
