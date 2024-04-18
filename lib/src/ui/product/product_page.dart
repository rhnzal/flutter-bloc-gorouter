import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/route.dart';
import 'package:flutter_bloc_architecture/src/bloc/cart/cart_cubit.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/cart/cart_page.dart';
import 'package:go_router/go_router.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = context.read<CartCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Product Id: $productId'),
            ElevatedButton(
              onPressed: () {
                // GoRouter.of(context).goNamed('/shopping/product/$productId/cart');

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: cartCubit,
                      child: const CartPage(),
                    ),
                  )
                );
              },
              child: const Text('Cart')
            ),
            ElevatedButton(
              onPressed: () {
                // GoRouter.of(context).go('/shopping/product/$productId/cart/product/$simmiliarProductId');

                Random random = Random();
                int min = 1000;
                int max = 9999;
                int rngProductId = min + random.nextInt(max - min + 1);

                // disini pake navigator aja karena ga mungkin pake gorouter routenya tidak masuk akal
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: cartCubit,
                      child:
                          ProductPage(productId: rngProductId.toString()),
                    ),
                  )
                );
              },
              child: const Text('Similiar Product')
            ),
            ElevatedButton(
              onPressed: () {
                cartCubit.addToCart(productId);
              },
              child: const Text('Add to cart')
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.homePage);
              },
              child: const Text('GO HOME')
            ),
          ],
        ),
      ),
    );
  }
}
