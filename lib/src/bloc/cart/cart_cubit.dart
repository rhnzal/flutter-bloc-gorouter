import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitialState([]));

  void addToCart(String productId) {
    List<String> newState = List.from(state.cart);
    newState.add(productId);

    emit(CartInitialState(newState));
  }
}
