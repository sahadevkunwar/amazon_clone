import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
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
        Image.asset(
          'assets/images/amazon_in.png',
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: const Text(
            '\$100',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            left: 15,
            top: 5,
            right: 40,
          ),
          child: const Text(
            'Sahadev',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/amazon_in.png',
                  fit: BoxFit.fitWidth,
                  height: 100,
                  width: 100,
                ),
                Image.asset(
                  'assets/images/amazon_in.png',
                  fit: BoxFit.fitWidth,
                  height: 100,
                  width: 100,
                ),
                Image.asset(
                  'assets/images/amazon_in.png',
                  fit: BoxFit.fitWidth,
                  height: 100,
                  width: 100,
                ),
                Image.asset(
                  'assets/images/amazon_in.png',
                  fit: BoxFit.fitWidth,
                  height: 100,
                  width: 100,
                ),
                Image.asset(
                  'assets/images/amazon_in.png',
                  fit: BoxFit.fitWidth,
                  height: 100,
                  width: 100,
                ),
                Image.asset(
                  'assets/images/amazon_in.png',
                  fit: BoxFit.fitWidth,
                  height: 100,
                  width: 100,
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(
            left: 15,
            top: 15,
            right: 15,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            'See all deals',
            style: TextStyle(color: Colors.cyan[800]),
          ),
        )
      ],
    );
  }
}
