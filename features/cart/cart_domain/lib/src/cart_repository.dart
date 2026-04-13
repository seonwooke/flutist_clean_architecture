import 'cart.dart';
import 'cart_item.dart';

abstract class CartRepository {
  Future<Cart> getCart();
  Future<void> addItem(CartItem item);
  Future<void> removeItem(String productId);
  Future<void> clearCart();
}
