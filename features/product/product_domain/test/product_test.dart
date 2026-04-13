import 'package:product_domain/product_domain.dart';
import 'package:test/test.dart';

void main() {
  group('Product', () {
    const product = Product(
      id: '1',
      name: 'Wireless Headphones',
      description: 'Premium sound quality.',
      price: 79.99,
    );

    test('supports value equality', () {
      const other = Product(
        id: '1',
        name: 'Wireless Headphones',
        description: 'Premium sound quality.',
        price: 79.99,
      );
      expect(product, equals(other));
    });

    test('props contains all fields', () {
      expect(
        product.props,
        equals(['1', 'Wireless Headphones', 'Premium sound quality.', 79.99]),
      );
    });

    test('different id → not equal', () {
      const other = Product(
        id: '2',
        name: 'Wireless Headphones',
        description: 'Premium sound quality.',
        price: 79.99,
      );
      expect(product, isNot(equals(other)));
    });

    test('different price → not equal', () {
      const other = Product(
        id: '1',
        name: 'Wireless Headphones',
        description: 'Premium sound quality.',
        price: 99.99,
      );
      expect(product, isNot(equals(other)));
    });
  });
}
