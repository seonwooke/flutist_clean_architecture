import 'package:cart_domain/cart_domain.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {
  const CartInitial();
}

final class CartLoading extends CartState {
  const CartLoading();
}

final class CartSuccess extends CartState {
  const CartSuccess({required this.cart});
  final Cart cart;
}

final class CartFailure extends CartState {
  const CartFailure({required this.message});
  final String message;
}
