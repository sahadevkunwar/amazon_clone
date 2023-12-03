import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color backColors;
  final Color foreColor;
  final String text;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.backColors,
    required this.foreColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backColors),
        foregroundColor: MaterialStateProperty.all<Color>(foreColor),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
