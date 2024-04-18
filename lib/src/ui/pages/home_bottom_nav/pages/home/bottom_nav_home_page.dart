import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/route.dart';
import 'package:go_router/go_router.dart';


class BottomNavHomePage extends StatefulWidget {
  const BottomNavHomePage({super.key});

  @override
  State<BottomNavHomePage> createState() => _BottomNavHomePageState();
}

class _BottomNavHomePageState extends State<BottomNavHomePage> {

  @override
  void initState() {
    super.initState();
    print('Switch to home page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).goNamed(AppPage.homePage);
            }, 
            child: Text('Go to main page')
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('HOME'),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.bottomNavHomeDetailPage);
              }, 
              child: Text('View Detail')
            )
          ],
        ),
      ),
    );
  }
}