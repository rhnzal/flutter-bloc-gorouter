import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/route.dart';
import 'package:flutter_bloc_architecture/src/bloc/global/global_cubit.dart';

class App extends StatelessWidget {
  App({super.key});

  AppRoute appRoute = AppRoute();

  GlobalCubit globalCubit = GlobalCubit()..checkIsLogedIn();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoute.router,
    );
  }
}
