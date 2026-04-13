import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class Cart extends Equatable {
  const Cart({required this.items});

  final List<CartItem> items;

  double get total =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);

  @override
  List<Object?> get props => [items];
}
