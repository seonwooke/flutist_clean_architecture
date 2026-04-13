import 'package:cart_domain/cart_domain.dart';
import 'package:test/test.dart';

void main() {
  group('Cart', () {
    group('total', () {
      test('is 0 for empty cart', () {
        const cart = Cart(items: []);
        expect(cart.total, 0.0);
      });

      test('is price × quantity for single item', () {
        const cart = Cart(items: [
          CartItem(productId: '1', name: 'A', price: 10.0, quantity: 3),
        ]);
        expect(cart.total, closeTo(30.0, 0.001));
      });

      test('sums across multiple items', () {
        const cart = Cart(items: [
          CartItem(productId: '1', name: 'A', price: 10.0, quantity: 2),
          CartItem(productId: '2', name: 'B', price: 5.0, quantity: 1),
        ]);
        expect(cart.total, closeTo(25.0, 0.001));
      });

      test('handles fractional prices correctly', () {
        const cart = Cart(items: [
          CartItem(productId: '1', name: 'A', price: 9.99, quantity: 2),
        ]);
        expect(cart.total, closeTo(19.98, 0.001));
      });
    });

    group('equality', () {
      test('supports value equality with same items', () {
        const a = Cart(items: [
          CartItem(productId: '1', name: 'A', price: 10.0, quantity: 1),
        ]);
        const b = Cart(items: [
          CartItem(productId: '1', name: 'A', price: 10.0, quantity: 1),
        ]);
        expect(a, equals(b));
      });

      test('not equal when items differ', () {
        const a = Cart(items: [
          CartItem(productId: '1', name: 'A', price: 10.0, quantity: 1),
        ]);
        const b = Cart(items: [
          CartItem(productId: '2', name: 'B', price: 5.0, quantity: 1),
        ]);
        expect(a, isNot(equals(b)));
      });

      test('empty carts are equal', () {
        const a = Cart(items: []);
        const b = Cart(items: []);
        expect(a, equals(b));
      });
    });
  });
}
