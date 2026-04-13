import 'package:cart_domain/cart_domain.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItem> _items = [];

  @override
  Future<Cart> getCart() async => Cart(items: List.unmodifiable(_items));

  @override
  Future<void> addItem(CartItem item) async {
    final index = _items.indexWhere((i) => i.productId == item.productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + item.quantity,
      );
    } else {
      _items.add(item);
    }
  }

  @override
  Future<void> removeItem(String productId) async {
    _items.removeWhere((i) => i.productId == productId);
  }

  @override
  Future<void> clearCart() async => _items.clear();
}
