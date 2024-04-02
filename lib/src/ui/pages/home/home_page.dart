// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/route.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.multiListPage);
              }, 
              child: Text('Multi List')
            ),

            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.userListPage);
              }, 
              child: Text('User List')
            ),

            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.loginPage);
              }, 
              child: Text('Login')
            ),
          ],
        ),
      ),
    );
  }
}