import 'package:cart_domain/cart_domain.dart';
import 'package:test/test.dart';

void main() {
  group('CartItem', () {
    const item = CartItem(
      productId: 'p1',
      name: 'Widget',
      price: 9.99,
      quantity: 2,
    );

    test('supports value equality', () {
      const other = CartItem(
        productId: 'p1',
        name: 'Widget',
        price: 9.99,
        quantity: 2,
      );
      expect(item, equals(other));
    });

    test('props contains all fields', () {
      expect(item.props, equals(['p1', 'Widget', 9.99, 2]));
    });

    test('different productId → not equal', () {
      const other = CartItem(
        productId: 'p2',
        name: 'Widget',
        price: 9.99,
        quantity: 2,
      );
      expect(item, isNot(equals(other)));
    });

    test('different quantity → not equal', () {
      const other = CartItem(
        productId: 'p1',
        name: 'Widget',
        price: 9.99,
        quantity: 5,
      );
      expect(item, isNot(equals(other)));
    });

    group('copyWith', () {
      test('updates quantity', () {
        final updated = item.copyWith(quantity: 10);
        expect(updated.quantity, 10);
      });

      test('preserves all other fields', () {
        final updated = item.copyWith(quantity: 10);
        expect(updated.productId, item.productId);
        expect(updated.name, item.name);
        expect(updated.price, item.price);
      });

      test('without arguments returns equivalent item', () {
        final copy = item.copyWith();
        expect(copy, equals(item));
      });
    });
  });
}
