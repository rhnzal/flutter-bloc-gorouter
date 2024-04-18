part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState(this.cart);

  final List<String> cart;

  @override
  List<Object> get props => [cart];
}

final class CartInitialState extends CartState {
  const CartInitialState(super.cart);
}