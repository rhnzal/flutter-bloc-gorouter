import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/route.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/home_bottom_nav/pages/home/bottom_nav_home_page.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/home_bottom_nav/pages/notification/notification_page.dart';
import 'package:go_router/go_router.dart';

// buat ini ikutin aja

class ScaffolBottomNav extends StatefulWidget {
  const ScaffolBottomNav({super.key, required this.child});

  final Widget child;

  @override
  State<ScaffolBottomNav> createState() => _ScaffolBottomNavState();
}

class _ScaffolBottomNavState extends State<ScaffolBottomNav> {

  int calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/bottom-nav-home')) {
      return 0;
    }

    if (location.startsWith('/bottom-nav-notif')) {
      return 1;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          switch(index) {
            case 0:
              GoRouter.of(context).goNamed(AppPage.bottomNavHomePage);
            case 1:
              GoRouter.of(context).goNamed(AppPage.bottomNavNotificationPage);
          }
        },
        currentIndex: calculateSelectedIndex(context),
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification'
          ),
        ]
      ),
    );
  }
}