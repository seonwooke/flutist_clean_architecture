import 'package:cart_domain/cart_domain.dart';

sealed class CartEvent {}

final class CartStarted extends CartEvent {}

final class CartItemAdded extends CartEvent {
  CartItemAdded(this.item);
  final CartItem item;
}

final class CartItemRemoved extends CartEvent {
  CartItemRemoved(this.productId);
  final String productId;
}

final class CartCleared extends CartEvent {}
