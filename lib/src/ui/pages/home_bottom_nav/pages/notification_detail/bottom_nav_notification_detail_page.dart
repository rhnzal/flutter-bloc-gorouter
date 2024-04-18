import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavNotificationDetailPage extends StatelessWidget {
  const BottomNavNotificationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Detail Page'),),
      body: Center(child: Text('NOTIFICATION DETAIL'),),
    );
  }
}