import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/route.dart';

class App extends StatelessWidget {

  App({super.key});

  AppRoute appRoute = AppRoute();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoute.router,
    );
  }
}