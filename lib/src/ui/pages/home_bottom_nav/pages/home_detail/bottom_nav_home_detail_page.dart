import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavHomeDetailPage extends StatelessWidget {
  const BottomNavHomeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Detail page'),),
      body: Center(child: Text('HOME DETAIL'),),
    );
  }
}