import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/route.dart';
import 'package:go_router/go_router.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  final String productId = '1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.cartPage);
              },
              child: const Text('Cart')
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.productPage, pathParameters:{'pid': '1234'});
              },
              child: const Text('Product')
            ),
          ],
        ),
      ),
    );
  }
}