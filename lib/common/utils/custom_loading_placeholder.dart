import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingPlaceholder extends StatelessWidget {
  const CustomLoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingCircle(
        color: Colors.white, // Set the color of the loading indicator
        size: 30.0, // Set the size of the loading indicator
      ),
    );
  }
}
