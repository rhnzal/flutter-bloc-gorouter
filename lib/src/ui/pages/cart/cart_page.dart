import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/cart/cart_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = context.read<CartCubit>();

    return Scaffold(
      appBar: AppBar(title: Text('Cart'),),
      body: Center(
        child: Column(
          children: List.generate(cartCubit.state.cart.length, (index) => Text(cartCubit.state.cart[index])),
        ),
      ),
    );
  }
}