import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/route.dart';
import 'package:go_router/go_router.dart';

class BottomNavNotificationPage extends StatefulWidget {
  const BottomNavNotificationPage({super.key});

  @override
  State<BottomNavNotificationPage> createState() => _BottomNavNotificationPageState();
}

class _BottomNavNotificationPageState extends State<BottomNavNotificationPage> {

  @override
  void initState() {
    super.initState();
    print('Switch to notification page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Page'),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('NOTIFICATION'),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.bottomNavNotificationDetailPage);
              }, 
              child: Text('View Detail')
            )
          ],
        ),
      ),
    );
  }
}