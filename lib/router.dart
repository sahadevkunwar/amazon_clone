import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen_widget.dart';
import 'package:flutter/material.dart';

MaterialPageRoute generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreenWidget.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>
            const Scaffold(body: Center(child: Text("Screen does not exist"))),
      );
  }
}
