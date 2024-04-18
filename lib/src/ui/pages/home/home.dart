import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../route.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({super.key});
  
  @override
  Size get preferredSize => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
  
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/multi-list');
            },
            child: Text('Multi List')
          ),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/user-list');
            },
            child: Text('User List')
          ),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/login');
            },
            child: Text('Login')
          ),
        ],
      ),
    );
  }
}