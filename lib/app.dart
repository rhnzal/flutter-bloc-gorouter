import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/route.dart';

class App extends StatelessWidget {
  final AppRoute appRoute = AppRoute();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // Menggunakan bloc access generated route access, sehingga bloc perlu dimasukan ke setiap halaman yang membutuhkan, lihat di file route.dart
      initialRoute: AppPage.homePage,
      onGenerateRoute: appRoute.onRoute,
    );
  }
}