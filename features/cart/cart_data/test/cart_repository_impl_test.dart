import 'package:cart_data/cart_data.dart';
import 'package:cart_domain/cart_domain.dart';
import 'package:test/test.dart';

void main() {
  group('CartRepositoryImpl', () {
    late CartRepositoryImpl repository;

    const item1 = CartItem(
      productId: 'p1',
      name: 'Widget',
      price: 10.0,
      quantity: 1,
    );
    const item2 = CartItem(
      productId: 'p2',
      name: 'Gadget',
      price: 20.0,
      quantity: 1,
    );

    setUp(() {
      repository = CartRepositoryImpl();
    });

    test('initial cart is empty', () async {
      final cart = await repository.getCart();
      expect(cart.items, isEmpty);
    });

    group('addItem', () {
      test('adds new item to empty cart', () async {
        await repository.addItem(item1);

        final cart = await repository.getCart();
        expect(cart.items.length, 1);
        expect(cart.items.first.productId, 'p1');
      });

      test('adds multiple different items', () async {
        await repository.addItem(item1);
        await repository.addItem(item2);

        final cart = await repository.getCart();
        expect(cart.items.length, 2);
      });

      test('increments quantity when same product added again', () async {
        await repository.addItem(item1);
        await repository.addItem(item1);

        final cart = await repository.getCart();
        expect(cart.items.length, 1);
        expect(cart.items.first.quantity, 2);
      });

      test('accumulates quantity across multiple adds', () async {
        await repository.addItem(item1);
        await repository.addItem(item1);
        await repository.addItem(item1);

        final cart = await repository.getCart();
        expect(cart.items.first.quantity, 3);
      });

      test('does not affect other items when adding a duplicate', () async {
        await repository.addItem(item1);
        await repository.addItem(item2);
        await repository.addItem(item1);

        final cart = await repository.getCart();
        expect(cart.items.length, 2);
        final p1 = cart.items.firstWhere((i) => i.productId == 'p1');
        final p2 = cart.items.firstWhere((i) => i.productId == 'p2');
        expect(p1.quantity, 2);
        expect(p2.quantity, 1);
      });
    });

    group('removeItem', () {
      test('removes existing item from cart', () async {
        await repository.addItem(item1);
        await repository.removeItem('p1');

        final cart = await repository.getCart();
        expect(cart.items, isEmpty);
      });

      test('only removes the matching product', () async {
        await repository.addItem(item1);
        await repository.addItem(item2);
        await repository.removeItem('p1');

        final cart = await repository.getCart();
        expect(cart.items.length, 1);
        expect(cart.items.first.productId, 'p2');
      });

      test('does nothing when product not in cart', () async {
        await repository.addItem(item1);
        await repository.removeItem('nonexistent');

        final cart = await repository.getCart();
        expect(cart.items.length, 1);
      });

      test('removing from empty cart is safe', () async {
        await repository.removeItem('p1');

        final cart = await repository.getCart();
        expect(cart.items, isEmpty);
      });
    });

    group('clearCart', () {
      test('removes all items', () async {
        await repository.addItem(item1);
        await repository.addItem(item2);
        await repository.clearCart();

        final cart = await repository.getCart();
        expect(cart.items, isEmpty);
      });

      test('clearing empty cart is safe', () async {
        await repository.clearCart();

        final cart = await repository.getCart();
        expect(cart.items, isEmpty);
      });

      test('items can be added again after clear', () async {
        await repository.addItem(item1);
        await repository.clearCart();
        await repository.addItem(item2);

        final cart = await repository.getCart();
        expect(cart.items.length, 1);
        expect(cart.items.first.productId, 'p2');
      });
    });

    test('getCart returns unmodifiable list', () async {
      await repository.addItem(item1);

      final cart = await repository.getCart();
      expect(
        () => (cart.items as List<CartItem>).add(item2),
        throwsUnsupportedError,
      );
    });
  });
}
