import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class AddressBox extends StatelessWidget {
  final User user;
  const AddressBox({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1],
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Text(
            'Delivery to ${user.name} -',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 2, right: 3),
            child: Icon(
              Icons.arrow_drop_down_rounded,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
